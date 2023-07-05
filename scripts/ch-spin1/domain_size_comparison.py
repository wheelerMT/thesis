import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 26})
matplotlib.use("TkAgg")

data_5000 = h5py.File("../thesis_data/1d_BA-FM_5000.hdf5", "r")
psi_1_5000 = data_5000["wavefunction/psi_plus"][140:356, -1]
data_500 = h5py.File("../thesis_data/1d_BA-FM_500.hdf5", "r")
psi_1_500 = data_500["wavefunction/psi_plus"][130:240, -1]

# Grid data
x = data_500["grid/x"][...]

fig, ax = plt.subplots(1, )
ax.set_ylabel(r"$|\psi_1|^2/n_0$")
ax.set_xlabel(r"Spatial extent, $\xi_s$")
ax.plot(
    x[140:356] - x[140:356].mean(),
    abs(psi_1_5000) ** 2,
    "k",
    label=r"$\tau_Q=5000$",
)
ax.plot(
    x[130:240] - x[130:240].mean(),
    abs(psi_1_500) ** 2,
    "gold",
    label=r"$\tau_Q=500$",
)
ax.legend(loc=8, prop={'size': 14})
plt.savefig('gfx/ch-spin1/BA-FM_domain_width.pdf', bbox_inches='tight')
plt.show()
