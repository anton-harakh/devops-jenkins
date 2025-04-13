package org.example;

/**
 * The main class to demonstrate application entry point.
 */
public final class Main {

    /**
     * Private constructor to prevent instantiation.
     * <p>
     * This class is not meant to be instantiated.
     * </p>
     */
    private Main() {
        throw new UnsupportedOperationException("Utility class");
    }

    /**
     * The entry point of the application.
     *
     * @param args the input arguments
     */
    public static void main(final String[] args) {
        System.out.println("Hello, World!");
    }
}
