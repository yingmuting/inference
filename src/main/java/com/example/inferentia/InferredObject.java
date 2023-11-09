package com.example.inferentia;

public class InferredObject {

    private String objectClass;

    private Double probability;

    public InferredObject(){}

    public InferredObject(String objectClass, Double probability) {
        this.objectClass = objectClass;
        this.probability = probability;
    }

    public String getObjectClass() {
        return objectClass;
    }

    public Double getProbability() {
        return probability;
    }
}
