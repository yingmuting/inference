package com.example.inferentia;

import ai.djl.ModelException;
import ai.djl.inference.Predictor;
import ai.djl.modality.Classifications;
import ai.djl.modality.cv.Image;
import ai.djl.modality.cv.ImageFactory;
import ai.djl.translate.TranslateException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.AmazonS3URI;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.LinkedList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

@RestController
public class InferencePointController {
    private static final Logger logger = LoggerFactory.getLogger(InferencePointController.class);

    @Resource
    private Predictor<Image, Classifications> predictor;


    @GetMapping
    @RequestMapping("/inference")
    public InferenceResponse detect(@RequestParam(name = "file") String fileName)
            throws IOException, ModelException, TranslateException, ExecutionException, InterruptedException {
        long start = System.nanoTime();
        String url = "https://resources.djl.ai/images/kitten.jpg";
        if (fileName != null && !fileName.isEmpty()) {
            url = fileName;
        }
        Image img = null;
        if (url.startsWith("s3://")) {
            img = getS3Object(url);
        } else {
            img = ImageFactory.getInstance().fromUrl(url);
        }
        LinkedList<InferredObject> inferredObjects = new LinkedList<InferredObject>();
        String outputReference = "";

        Classifications result = predictor.predict(img);

        long end = System.nanoTime();
        long used = end - start;
        logger.info("top5------" + result.toString());
        result.topK(5).forEach(e -> inferredObjects.add(new InferredObject(e.getClassName(), e.getProbability())));
        return new InferenceResponse(TimeUnit.NANOSECONDS.toMillis(used), inferredObjects, outputReference);
    }

    private Image getS3Object(String url) {
        logger.info("Downloading {} from S3 ...\n", url);
        AmazonS3URI uri = new AmazonS3URI(url);
        logger.info("uri:{}", uri.toString());
        Image img = null;
        final AmazonS3 s3 = AmazonS3ClientBuilder.standard().withRegion(Regions.US_EAST_1).build();
        try {
            S3Object o = s3.getObject(uri.getBucket(), uri.getKey());
            S3ObjectInputStream s3is = o.getObjectContent();
            img = ImageFactory.getInstance().fromInputStream(s3is);
            s3is.close();
        } catch (AmazonServiceException e) {
            System.err.println(e.getErrorMessage());
            System.exit(1);
        } catch (IOException e) {
            System.err.println(e.getMessage());
            System.exit(1);
        }
        return img;
    }


}
