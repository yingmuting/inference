package com.example.inferentia;

import java.util.List;

public class InferenceResponse {

    private long time;

    private String outputReference;

    private List<InferredObject> inferredObjects;

    /**
     * Deserialization constructor
     */
    public InferenceResponse() {
    }

    public InferenceResponse(long time, List<InferredObject> inferredObjects,
                             String outputReference) {
        this.time = time;
        this.inferredObjects = inferredObjects;
        this.outputReference = outputReference;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public List<InferredObject> getInferredObjects() {
        return inferredObjects;
    }

    public void setInferredObjects(List<InferredObject> inferredObjects) {
        this.inferredObjects = inferredObjects;
    }

    public String getOutputReference() {
        return outputReference;
    }

    public void setOutputReference(String outputReference) {
        this.outputReference = outputReference;
    }
}
