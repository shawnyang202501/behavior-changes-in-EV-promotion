

from __future__ import annotations

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.colors import BoundaryNorm, ListedColormap


FIGURE_WIDTH_PX = 1267
FIGURE_HEIGHT_PX = 660
FIGURE_DPI = 220
ZERO_COLOR = "#EEEEEE"
ONE_COLOR = "#4A4A4A"
TITLE = "treat-ym-id_table"
X_LABEL = "ym"
Y_LABEL = "id"


def find_default_csv() -> Path:
    folder = Path(r"C:\Users\Shawn\Desktop\fig")
    candidates = sorted(folder.glob("*.csv"))
    if not candidates:
        raise FileNotFoundError(f"No CSV file found in {folder}")
    return candidates[0]


def read_matrix(csv_path: Path) -> tuple[pd.DataFrame, np.ndarray]:
    df = pd.read_csv(csv_path)
    required = {"treat", "ym", "id"}
    missing = required.difference(df.columns)
    if missing:
        raise ValueError(f"Missing columns: {sorted(missing)}")

    matrix = df.pivot(index="id", columns="ym", values="treat").sort_index(axis=1)
    if matrix.isna().any().any():
        raise ValueError("The id-by-ym grid contains missing values.")

    values = set(np.unique(matrix.to_numpy()))
    if not values.issubset({0, 1}):
        raise ValueError(f"treat must be binary; found {sorted(values)}")

    row_order = matrix.sum(axis=1).sort_values(
        ascending=False, kind="mergesort"
    ).index
    matrix = matrix.loc[row_order]
    return matrix, matrix.to_numpy(dtype=int)


def create_plot(csv_path: Path, output_path: Path) -> None:
    matrix, z = read_matrix(csv_path)
    cmap = ListedColormap([ZERO_COLOR, ONE_COLOR], name="treat_binary")
    norm = BoundaryNorm([-0.5, 0.5, 1.5], cmap.N)

    fig = plt.figure(
        figsize=(FIGURE_WIDTH_PX / FIGURE_DPI, FIGURE_HEIGHT_PX / FIGURE_DPI),
        dpi=FIGURE_DPI,
        facecolor="white",
    )
    ax = fig.add_axes(
        [
            97 / FIGURE_WIDTH_PX,
            (FIGURE_HEIGHT_PX - 580) / FIGURE_HEIGHT_PX,
            (1111 - 97) / FIGURE_WIDTH_PX,
            (580 - 48) / FIGURE_HEIGHT_PX,
        ]
    )
    ax.imshow(
        z,
        cmap=cmap,
        norm=norm,
        interpolation="nearest",
        aspect="auto",
        origin="upper",
    )
    ax.set_xticks([])
    ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_color(ONE_COLOR)
        spine.set_linewidth(0.8)

    fig.text(0.5, 0.978, TITLE, ha="center", va="top", color=ONE_COLOR, fontsize=8)
    fig.text(0.5, 0.055, X_LABEL, ha="center", va="center", color=ONE_COLOR, fontsize=8)
    fig.text(
        0.035,
        0.52,
        Y_LABEL,
        ha="center",
        va="center",
        color=ONE_COLOR,
        fontsize=8,
        rotation=90,
    )
    fig.savefig(output_path, dpi=FIGURE_DPI, facecolor="white")
    plt.close(fig)

    print(f"saved: {output_path}")
    print(f"matrix: {matrix.shape[0]} rows x {matrix.shape[1]} columns")


def main() -> None:
    parser = argparse.ArgumentParser(description="Create a treat-ym-id raster plot")
    parser.add_argument("--csv", type=Path, default=None, help="Input CSV path")
    parser.add_argument("--output", type=Path, default=None, help="Output PNG path")
    args = parser.parse_args()

    csv_path = (args.csv or find_default_csv()).expanduser().resolve()
    output_path = args.output or csv_path.with_name("treat_plot.png")
    output_path.parent.mkdir(parents=True, exist_ok=True)
    create_plot(csv_path, output_path)


if __name__ == "__main__":
    main()
