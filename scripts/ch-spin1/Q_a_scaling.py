import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 20})
matplotlib.use("TkAgg")

quenches = [i for i in range(200, 1000, 100)] + [
    i for i in range(1000, 8500, 500)
]

Q_a = []
Q_a_std = []
for quench in quenches:
    with h5py.File("../thesis_data/1d_BA-FM_Q_a.hdf5", "r") as file:
        Q_a_total = abs(file[f"{quench}/Q_a"][...])
        Q_a_std.append(np.std(Q_a_total))
        Q_a.append(sum(Q_a_total) / len(Q_a_total))

fig, ax = plt.subplots(1, figsize=(6.4, 3.8))
ax.set_ylabel(r"$|Q_a|$")
ax.set_xlabel(r"$\tau_Q$")
ax.errorbar(
    quenches,
    Q_a,
    yerr=Q_a_std,
    capsize=5,
    ecolor="k",
    fmt="none",
)
ax.loglog(quenches, Q_a, "ko", markerfacecolor='None')
ax.loglog(
    quenches[:-1],
    1.2e1 * np.array(quenches[:-1]) ** (-1 / 2),
    "k--",
    label=r"$\tau_Q^{-1/2}$",
)
plt.legend()
plt.savefig("gfx/ch-spin1/BA-FM_Qa_scaling.pdf", bbox_inches="tight")
plt.show()