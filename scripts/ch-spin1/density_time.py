import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 14})
matplotlib.use("TkAgg")

data_file = h5py.File("../thesis_data/1d_BA-FM_1000.hdf5", "r")

index_range = slice(8196 - 1024, 8196 + 1024)
x = data_file["grid/x"][index_range]
time = data_file["time/t"][:, 0]
psi_plus = data_file["wavefunction/psi_plus"][index_range, :]
psi_0 = data_file["wavefunction/psi_0"][index_range, :]
psi_minus = data_file["wavefunction/psi_minus"][index_range, :]

num_of_frames = psi_plus.shape[-1]
spacetime_plus = np.empty((2048, num_of_frames))
spacetime_0 = np.empty((2048, num_of_frames))
spacetime_minus = np.empty((2048, num_of_frames))
for i in range(num_of_frames):
    spacetime_plus[:, i] = abs(psi_plus[:, i]) ** 2
    spacetime_0[:, i] = abs(psi_0[:, i]) ** 2
    spacetime_minus[:, i] = abs(psi_minus[:, i]) ** 2

extent = time.min(), time.max(), x.min(), x.max()

fig, ax = plt.subplots(3, figsize=(6.4, 3))
ax[0].set_xticks([])
ax[1].set_xticks([])
for axis in ax:
    axis.set_ylabel(r"$x/\xi_s$", labelpad=-10)
ax[2].set_xlabel(r'$t/\tau$')

plot = ax[0].imshow(spacetime_plus, extent=extent, vmin=0, vmax=1, aspect='auto')
ax[1].imshow(spacetime_0, extent=extent, vmin=0, vmax=1, aspect='auto')
ax[2].imshow(spacetime_minus, extent=extent, vmin=0, vmax=1, aspect='auto')

cbar = fig.colorbar(
    plot, ax=ax.ravel().tolist(), location="right", anchor=(1.3, 0)
)
cbar.set_ticks([0, 1])
cbar.set_label(r"$|\psi_1|^2/n_0$", labelpad=-10)

plt.subplots_adjust(hspace=0.04)
plt.savefig('gfx/ch-spin1/BA-FM_all_densities.pdf', bbox_inches='tight')
plt.show()
