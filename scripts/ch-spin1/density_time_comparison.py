import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 26})
matplotlib.use("TkAgg")

data_5000 = h5py.File("../thesis_data/1d_BA-FM_500.hdf5", "r")
data_1000 = h5py.File("../thesis_data/1d_BA-FM_1000.hdf5", "r")

index_range = slice(8196 - 1024, 8196 + 1024)
x = data_1000["grid/x"][index_range]
time_5000 = data_5000["time/t"][:, 0]
time_1000 = data_1000["time/t"][:, 0]
psi_1_5000 = data_5000["wavefunction/psi_plus"][index_range, :]
psi_1_1000 = data_1000["wavefunction/psi_plus"][index_range, :]

num_of_frames = psi_1_1000.shape[-1]
spacetime_plus_1000 = np.empty((2048, num_of_frames))
spacetime_plus_5000 = np.empty((2048, num_of_frames))

for i in range(num_of_frames):
    spacetime_plus_1000[:, i] = abs(psi_1_1000[:, i]) ** 2
    spacetime_plus_5000[:, i] = abs(psi_1_5000[:, i]) ** 2

extent = 0, time_5000.max(), x.min(), x.max()

fig, ax = plt.subplots(2)
ax[0].set_xlim(0, time_5000.max())
ax[0].set_xticks([])
ax[1].set_xlim(0, time_5000.max())
for axis in ax:
    axis.set_ylabel(r"$x/\xi_s$", labelpad=-25)
ax[1].set_xlabel(r"$t/\tau$")
plot = ax[0].pcolormesh(
    time_5000, x[::2], spacetime_plus_5000[::2, :], vmin=0, vmax=1
)
ax[1].pcolormesh(time_1000, x[::2], spacetime_plus_1000[::2, :], vmin=0, vmax=1)

cbar = fig.colorbar(
    plot, ax=ax.ravel().tolist(), location="right", anchor=(1.5, 0)
)
cbar.set_ticks([0, 1])
cbar.set_label(r"$|\psi_1|^2/n_0$", labelpad=-10)

plt.subplots_adjust(hspace=0.04)
plt.savefig("gfx/ch-spin1/BA-FM_domain_onset.png", bbox_inches="tight", dpi=100)
plt.show()
