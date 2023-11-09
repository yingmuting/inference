package com.example.inferentia.config;

import ai.djl.MalformedModelException;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import ai.djl.modality.Classifications;
import ai.djl.modality.cv.Image;
import ai.djl.modality.cv.transform.CenterCrop;
import ai.djl.modality.cv.transform.Resize;
import ai.djl.modality.cv.transform.ToTensor;
import ai.djl.modality.cv.translator.ImageClassificationTranslator;
import ai.djl.repository.zoo.Criteria;
import ai.djl.repository.zoo.ModelNotFoundException;
import ai.djl.repository.zoo.ModelZoo;
import ai.djl.repository.zoo.ZooModel;
import ai.djl.translate.Pipeline;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;
import com.example.inferentia.InferencePointController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Configuration
public class InferenceConfiguration {

    private static final Logger LOG = LoggerFactory.getLogger(InferenceConfiguration.class);

    private static String modelUrlInf = "s3://us-east-1-bucket-001/models/inf/";
    private static String modelUrlOri = "s3://us-east-1-bucket-001/models/ori/";

    @Bean
    public Criteria<Image, Classifications> criteria() {
        LOG.info("Initializing criteria");
        String version = Engine.getEngine("PyTorch").getVersion();
        LOG.info("Running inference with PyTorch: " + version);
        String modelUrl = modelUrlOri;
        String paths = System.getenv("PYTORCH_EXTRA_LIBRARY_PATH");
        if (paths == null) {
            paths = System.getProperty("PYTORCH_EXTRA_LIBRARY_PATH");
        }
        if (paths != null) {
            modelUrl = modelUrlInf;
        }

        return Criteria.builder()
                .setTypes(Image.class, Classifications.class)
                .optModelUrls(modelUrl)
                .optModelName("resnet50")
                .optTranslator(getTranslator())
                .build();

    }

    private static Translator<Image, Classifications> getTranslator() {
        return ImageClassificationTranslator.builder()
                .addTransform(new CenterCrop())
                .addTransform(new Resize(224, 224))
                .addTransform(new ToTensor())
                .optSynsetUrl(InferencePointController.class.getResource("/synset.txt").toString())
                .optApplySoftmax(true)
                .build();
    }


    @Bean
    public ZooModel<Image, Classifications> model(Criteria<Image, Classifications> criteria) throws ModelNotFoundException, MalformedModelException, IOException {
        LOG.info("Initializing model");
        return ModelZoo.loadModel(criteria);
    }

    @Bean
    public Predictor<Image, Classifications> predictor(ZooModel<Image, Classifications> model) {
        LOG.info("Initializing predictor");
        return model.newPredictor();
    }

    @Bean
    public ExecutorService executorService() {
        LOG.info("Initializing executorService");
        return Executors.newFixedThreadPool(6);
    }

}


