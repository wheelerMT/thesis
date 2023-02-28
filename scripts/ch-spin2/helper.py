import cupy as cp


def get_tf_density_3d(c0, c2, X, Y, Z, N):
    """Get 3D Thomas-Fermi profile using interaction parameters
    for a spin-2 condensate."""
    g = c0 + 4 * c2
    rtf = (15 * N * g / (4 * cp.pi)) ** 0.2

    r2 = X**2 + Y**2 + Z**2
    tf_dens = 15 * N / (8 * cp.pi * rtf**2) * (1 - r2 / rtf**2)
    tf_dens = cp.where(tf_dens < 0, 0, tf_dens)

    return tf_dens


def get_linear_interp(z, gradient=0.25):
    linear_eta = gradient * z + 0.5
    linear_eta[linear_eta > 1] = 1
    linear_eta[linear_eta < 0] = 0

    return linear_eta
