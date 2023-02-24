import numpy as np
import matplotlib.pyplot as plt
import matplotlib

plt.rcParams["text.usetex"] = True
plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams.update({"font.size": 16})
matplotlib.use("TkAgg")

r = np.linspace(0, 6, 1000)
eta_C_FM = 3 * np.tanh(r / 2) - 1

mod_a30_C_FM = 0.5 * (2 - eta_C_FM) ** 2 * (1 + eta_C_FM)
psiP2 = np.sqrt((1 + eta_C_FM) / 3)
psiM1 = np.sqrt((2 - eta_C_FM) / 3)

mod_f = abs(2 * abs(psiP2) ** 2 - abs(psiM1) ** 2)
fig, ax = plt.subplots(1, figsize=(6.4, 4.8))
ax.set_xlim(0, 6)
ax.set_ylim(-0.1, 2.1)

ax.plot(r, mod_f, "k", label=r"$|\langle\hat{\mathbf{F}}(\rho)\rangle|$")
ax.plot(r, mod_a30_C_FM, "k--", label=r"$|A_{30}(\rho)|^2$")

ax.set_xlabel(r"$\rho$")
ax.set_ylabel("Value")
ax.set_yticks([0, 1, 2])
ax.set_yticklabels(["0", "1", "2"])
ax.legend()

plt.savefig(
    "gfx/ch-spin2/spin_singlet_radius_analytical.pdf",
    bbox_inches="tight",
)
plt.show()
