import numpy as np

def apply_sobel_operators(image):
    # Define Sobel operators
    sobel_x = np.array([[-1, 0, 1],
                        [-2, 0, 2],
                        [-1, 0, 1]])
    
    sobel_y = np.array([[-1, -2, -1],
                        [0, 0, 0],
                        [1, 2, 1]])
    
    # Get image dimensions
    rows, cols = image.shape
    
    # Initialize gradient matrices
    Gx = np.zeros((rows, cols))
    Gy = np.zeros((rows, cols))
    
    # Apply zero padding
    padded_image = np.pad(image, 1, mode='constant')
    
    # Compute gradients using convolution
    for i in range(rows):
        for j in range(cols):
            # Extract 3x3 neighborhood
            neighborhood = padded_image[i:i+3, j:j+3]
            
            # Compute Gx and Gy
            Gx[i, j] = np.sum(neighborhood * sobel_x)
            Gy[i, j] = np.sum(neighborhood * sobel_y)
    
    return Gx, Gy

def compute_gradient_magnitude_and_direction(Gx, Gy):
    # Compute gradient magnitude
    magnitude = np.sqrt(Gx**2 + Gy**2)
    
    # Compute gradient direction (in radians)
    direction = np.arctan2(Gy, Gx)
    
    return magnitude, direction

def main():
    # Given 5x5 image
    image = np.array([
        [50, 55, 60, 65, 70],
        [55, 60, 70, 75, 80],
        [60, 70, 150, 160, 90],
        [65, 75, 160, 170, 100],
        [70, 80, 90, 100, 110]
    ])
    
    # Compute gradients
    Gx, Gy = apply_sobel_operators(image)
    
    # Compute magnitude and direction
    magnitude, direction = compute_gradient_magnitude_and_direction(Gx, Gy)
    
    # Print results
    print("Original Image:")
    print(image)
    print("\nGradient in x-direction (Gx):")
    print(Gx)
    print("\nGradient in y-direction (Gy):")
    print(Gy)
    print("\nGradient Magnitude:")
    print(magnitude)
    print("\nGradient Direction (in radians):")
    print(direction)

if __name__ == "__main__":
    main()
