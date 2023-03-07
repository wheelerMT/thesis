import cupy as cp
import numpy as np


def calc_density(psip2, psip1, psi0, psim1, psim2):
    wavefunction = [psip2, psip1, psi0, psim1, psim2]
    return sum(abs(wfn) ** 2 for wfn in wavefunction)


def normalise_wfn(psip2, psip1, psi0, psim1, psim2):
    wavefunction = [psip2, psip1, psi0, psim1, psim2]
    n = calc_density(psip2, psip1, psi0, psim1, psim2)

    # Normalise wavefunction
    zeta = [wfn / np.sqrt(n) for wfn in wavefunction]

    return zeta


def calc_spin_vectors(psip2, psip1, psi0, psim1, psim2):
    fx = (
        np.conj(psim2) * psim1
        + np.conj(psim1) * (np.sqrt(3 / 2) * psi0 + psim2)
        + np.conj(psi0) * np.sqrt(3 / 2) * (psip1 + psim1)
        + np.conj(psip1) * (psip2 + np.sqrt(3 / 2) * psi0)
        + np.conj(psip2) * psip1
    )
    fy = 1j * (
        np.conj(psim2) * psim1
        + np.conj(psim1) * (np.sqrt(3 / 2) * psi0 - psim2)
        + np.conj(psi0) * np.sqrt(3 / 2) * (psip1 - psim1)
        + np.conj(psip1) * (psip2 - np.sqrt(3 / 2) * psi0)
        - np.conj(psip2) * psip1
    )
    fz = (
        2 * (np.abs(psip2) ** 2 - np.abs(psim2) ** 2)
        + np.abs(psip1) ** 2
        - np.abs(psim1) ** 2
    )
    return fx, fy, fz


def calc_spin_singlet_duo(zetap2, zetap1, zeta0, zetam1, zetam2):
    return (
        1
        / (np.sqrt(5))
        * (2 * zetap2 * zetam2 - 2 * zetap1 * zetam1 + zeta0**2)
    )


def calc_spin_singlet_trio(zetap2, zetap1, zeta0, zetam1, zetam2):
    return 3 * np.sqrt(6) / 2 * (
        zetap1**2 * zetam2 + zetam1**2 * zetap2
    ) + zeta0 * (zeta0**2 - 3 * zetap1 * zetam1 - 6 * zetap2 * zetam2)


def get_tf_density_3d(c0, c2, x, y, z, atom_num=1):
    """Get 3D Thomas-Fermi profile using interaction parameters
    for a spin-2 condensate."""
    g = c0 + 4 * c2
    rtf = (15 * atom_num * g / (4 * cp.pi)) ** 0.2

    r2 = x**2 + y**2 + z**2
    tf_dens = 15 * atom_num / (8 * cp.pi * rtf**2) * (1 - r2 / rtf**2)
    tf_dens = cp.where(tf_dens < 0, 0, tf_dens)

    return tf_dens


def get_linear_interp(z, gradient=0.25):
    linear_eta = gradient * z + 0.5
    linear_eta[linear_eta > 1] = 1
    linear_eta[linear_eta < 0] = 0

    return linear_eta
