import h5py
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 16})
matplotlib.use("TkAgg")

quenches = [i for i in range(200, 1000, 100)] + [
    i for i in range(1000, 8500, 500)
]

num_of_domains = []
domains_std = []
for quench in quenches:
    with h5py.File("../thesis_data/1d_BA-FM_domains.hdf5", "r") as file:
        nd_total = file[f"{quench}/nd_total"][...]
        domains_std.append(np.std(nd_total))
        num_of_domains.append(sum(nd_total) / len(nd_total))

fig, ax = plt.subplots(1, figsize=(6.4, 3.8))
ax.set_ylabel(r"$N_d$")
ax.set_xlabel(r"$\tau_Q$")
ax.errorbar(
    quenches,
    num_of_domains,
    yerr=domains_std,
    capsize=5,
    ecolor="k",
    fmt="none",
)
ax.loglog(quenches, num_of_domains, "ko")
ax.loglog(
    quenches[:11],
    11.5e2 * np.array(quenches[:11]) ** (-1 / 4),
    "k--",
    label=r"$\tau_Q^{-1/4}$",
)
plt.legend()
plt.savefig("gfx/ch-spin1/FM_domains_scaling.pdf", bbox_inches="tight")
plt.show()