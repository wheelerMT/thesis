import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 20})
matplotlib.use("TkAgg")

data = h5py.File("../thesis_data/1d_BA-FM_fluctuation_diff.hdf5", "r")
t = np.linspace(-1000, 2500, 1000)

fig, ax = plt.subplots(1, figsize=(6.4, 3.8))
ax.set_xlim(0, 0.05)
ax.set_ylim(-0.0001, 0.006)
ax.set_ylabel(r"$|\hat{a}_{k, f_z}|$")
ax.set_xlabel(r"$t/\tau_Q$")
ax.plot(t / 5000, abs(data['5000/2/difference'][...]), 'k')
plt.savefig("gfx/ch-spin1/1d_BA-FM_5000_fluctuation_diff.pdf",
            bbox_inches="tight")
plt.show()