import torch
import os
import torch_neuron
from torchvision import models
import logging

# Enable logging so we can see any important warnings
logger = logging.getLogger('Neuron')
logger.setLevel(logging.INFO)

# An example input you would normally provide to your model's forward() method.
image = torch.zeros([1, 3, 224, 224], dtype=torch.float32)

# Load a pretrained ResNet50 model
model = models.resnet50(pretrained=True)

# Tell the model we are using it for evaluation (not training)
model.eval()

# Use torch.jit.trace to generate a torch.jit.ScriptModule via tracing.
djl_traced_model = torch.jit.trace(model, image)

# Save the Regular TorchScript model for benchmarking
os.makedirs("models/djl/resnet50", exist_ok=True)
djl_traced_model.save("models/djl/resnet50/resnet50.pt")

# Analyze the model - this will show operator support and operator count
torch.neuron.analyze_model(model, example_inputs=[image])

# Now compile the model - with logging set to "info" we will see
# what compiles for Neuron, and if there are any fallbacks
# model_neuron = torch.neuron.trace(model, example_inputs=[image])
model_neuron = torch.neuron.trace(model, example_inputs=[image], verbose=1, compiler_args = ['--neuroncore-pipeline-cores', '4'])

# Export to saved model
os.makedirs("models/inferentia/resnet50", exist_ok=True)
model_neuron.save("models/inferentia/resnet50/resnet50.pt")
print("Compile success")
