import pickle as pickle
import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import h5py
import sys

sys.path.append("/home/mattwheeler/dev/python/two-component_BEC/")

plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams["text.usetex"] = True
plt.rcParams.update({"font.size": 20})
matplotlib.use("TkAgg")


def load_data(filename):
    with open(filename, "rb") as f:
        while True:
            try:
                yield pickle.load(f)
            except EOFError:
                break


# Load in vortex map pickled data:
maps_09 = load_data("../thesis_data/HQV_grid_gamma=09_VD.pkl")
maps_07 = load_data("../thesis_data/HQV_grid_gamma=07_VD.pkl")
maps_03 = load_data("../thesis_data/HQV_grid_gamma=03_VD.pkl")

# Empty vortex number lists:
vortexNum_09 = []
vortexNum_07 = []
vortexNum_03 = []

pickle_length = 0  # Counts number of elements in pickle file

# Loads in the maps and finds the total vortices in each Map and saves to a list
while True:
    try:
        current_map_09 = next(maps_09)
        current_map_07 = next(maps_07)
        current_map_03 = next(maps_03)

        vortexNum_09.append(current_map_09.total_vortices())
        vortexNum_07.append(current_map_07.total_vortices())
        vortexNum_03.append(current_map_03.total_vortices())

        pickle_length += 1
    except StopIteration:
        print("Exceeded length of pickle... Exiting loop.")
        break
print("Pickle length = {}".format(pickle_length))
time_array = np.arange(200 * pickle_length, step=200)  # Time

scalar_data = h5py.File("../thesis_data/grid_imag_VD.hdf5", "r")[
    "vortex_number"
]

# Set up plots:
fig, ax = plt.subplots(1, 3, sharex=True, figsize=(12, 4.8))
ax[0].set_ylabel(r"$N_\mathrm{vort}$")
ax[0].set_xlabel(r"$t/\tau$")
ax[1].set_xlabel(r"$t/\tau$")
ax[2].set_xlabel(r"$t/\tau$")

# Loglog plot on each axis:
ax[0].loglog(
    time_array[:],
    vortexNum_03[:],
    markersize=2,
    linestyle="--",
    marker="o",
    color="r",
)
ax[0].set_title(r"$\gamma=0.3$")

ax[1].loglog(
    time_array[:],
    vortexNum_07[:],
    markersize=2,
    linestyle="--",
    marker="o",
    color="r",
)
ax[1].set_title(r"$\gamma=0.7$")

ax[2].loglog(
    time_array[:],
    vortexNum_09[:],
    markersize=2,
    linestyle="--",
    marker="o",
    color="r",
)
ax[2].set_title(r"$\gamma=0.9$")

# Scalar line plots
for i in range(3):
    ax[i].loglog(
        time_array[:-2:2],
        2 * scalar_data[...],
        markersize=2,
        linestyle="--",
        marker="o",
        color="k",
    )

# Plot scaling lines:
ax[0].loglog(
    time_array[100:],
    2.2e4 * (time_array[100:] ** (-2.0 / 5)),
    "k",
    label=r"$t^{-2/5}$",
)
ax[0].legend(loc=3, fontsize=18)

ax[1].loglog(
    time_array[3:10],
    1.05e6 * (time_array[3:10] ** (-1.0)),
    "k--",
    label=r"$t^{-1}$",
)
ax[1].loglog(
    time_array[100:],
    7e3 * (time_array[100:] ** (-2 / 5)),
    "k",
    label=r"$t^{-2/5}$",
)
ax[1].legend(loc=3, fontsize=18)

ax[2].loglog(
    time_array[6:25],
    6e7 * (time_array[6:25] ** (-1.5)),
    "k:",
    label=r"$t^{-3/2}$",
)
ax[2].loglog(
    time_array[100:],
    2.8e3 * (time_array[100:] ** (-2 / 5)),
    "k",
    label=r"$t^{-2/5}$",
)
ax[2].legend(loc=3, fontsize=18)

plt.savefig(
    "gfx/ch-twoCompDynamics/vortex_number.pdf", bbox_inches="tight"
)
plt.show()
