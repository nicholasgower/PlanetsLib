import numpy as np
import matplotlib.pyplot as plt
import os
import math

def generate_circle(radius=1.0, thickness=0.1, width=1, resolution=1000, output_file="circle.png"):
    resolution=resolution/3.696
    if thickness <= 0 or radius <= 0:
        raise ValueError("Radius and thickness must be positive.")
    
    # Generate the outer and inner circles
    theta = np.linspace(0, 2 * np.pi, math.floor(resolution))
    outer_x = (radius + thickness / 2) * np.cos(theta) * width
    outer_y = (radius + thickness / 2) * np.sin(theta)
    inner_x = (radius - thickness / 2) * np.cos(theta) * width
    inner_y = (radius - thickness / 2) * np.sin(theta)

    # Create the figure and axis
    fig, ax = plt.subplots()
    ax.set_aspect('equal')
    # ax.fill(outer_x, outer_y, color='blue', label='Outer Boundary')
    # ax.fill(inner_x, inner_y, color='none', label='Inner Boundary')


    from matplotlib.patches import Polygon
    vertices = np.column_stack((np.append(outer_x, inner_x[::-1]), np.append(outer_y, inner_y[::-1])))
    ring = Polygon(vertices, closed=True, color='#191919', lw=thickness/2)
    ax.add_patch(ring)

    # Adjust plot limits and remove axes
    padding = 1
    ax.set_xlim(-(radius + thickness  + padding), radius + thickness  + padding)
    ax.set_ylim(-(radius + thickness  + padding), radius + thickness  + padding)
    ax.axis('off')

    # Save to file
    plt.savefig(output_file, bbox_inches="tight",pad_inches=0, dpi=resolution,transparent=True)
    plt.close()

    print(f"Circle saved to {os.path.abspath(output_file)}")


