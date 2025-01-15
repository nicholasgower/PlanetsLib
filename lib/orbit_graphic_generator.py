import numpy as np
import matplotlib.pyplot as plt
import os
import math

def generate_orbit(distance, output_file, mod_name):
    """Outputs an orbit sprite for a planet based on its distance, and prints a block of lua code that imports \
        the sprite with correct scaling and sprite siz

    distance: The planet's distance from its parent body.
    output_file: The name of the resulting image file, with file format.
    mod_name: The internal name of your mod.

    Example: generate_orbit(1.6, "orbit-muluna.png","planet-muluna")
    """

    width=1
    resolution=512*distance/2
    thickness = 3
    radius=distance*64
    resolution_old=resolution
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
    ax.set_xlim(-1*width*(radius + thickness  + padding), 1*width*(radius + thickness  + padding))
    ax.set_ylim(-(radius + thickness  + padding), radius + thickness  + padding)
    ax.axis('off')

    # Save to file
    plt.savefig(output_file, bbox_inches="tight",pad_inches=0, dpi=resolution,transparent=True)
    plt.close()

    print(f"Orbit sprite saved to {os.path.abspath(output_file)}\n")
    print(f"Add sprite to planet orbit with following code in your planet's orbit object:\n")
    print("""sprite = {{
        type = "sprite",
        filename = "__{}__/graphics/orbits/{}",
        size = {},
        scale = 0.25,
      }}""".format(mod_name,output_file,math.floor(resolution_old*(1+width)/2)))


