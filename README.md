#	Quantum Fisher information Toolbox 
This repository contains is a toolbox for exploring and manipulating multipartite entanglement and quantum Fisher information.

## Installation and Setup

To use the QFIEntanglementToolbox:
1. Clone this repository or download the source code.
2. Add the `src/` directory (located at the root of the repository) to your MATLAB path. You can do this using the `addpath` command in MATLAB, for example:
   ```matlab
   addpath('path/to/repository/src');
   % Optionally, save the path for future MATLAB sessions
   % savepath; 
   ```
3. Alternatively, you can add the root directory of the toolbox to the path, and then the package structure will be accessible.

## Basic Usage

Functions in this toolbox are organized into packages.
- Core physics functions are in the `QFIEntanglementToolbox` package. For example, to generate a GHZ state:
  ```matlab
  state = QFIEntanglementToolbox.GHZState(3);
  ```
- Utility functions are in the `QFIEntanglementToolbox.utils` sub-package. For example, to clean a matrix:
  ```matlab
  cleanedMatrix = QFIEntanglementToolbox.utils.cleanMat(originalMatrix, 1e-5);
  ```
Refer to the `Contents.m` files within these packages (`src/+QFIEntanglementToolbox/Contents.m` and `src/+QFIEntanglementToolbox/+utils/Contents.m`) or the generated API documentation for a full list of functions.

Example scripts demonstrating the use of various toolbox functions can be found in the `examples/` directory (to be populated).

## Theoretical background
Given a pure quantum state <img src="/tex/a516492fcf72611ad6fe4454514c00de.svg?invert_in_darkmode&sanitize=true" align=middle width=33.21534479999999pt height=24.65753399999998pt/>, we say that <img src="/tex/a516492fcf72611ad6fe4454514c00de.svg?invert_in_darkmode&sanitize=true" align=middle width=33.21534479999999pt height=24.65753399999998pt/> is <img src="/tex/63bb9849783d01d91403bc9a5fea12a2.svg?invert_in_darkmode&sanitize=true" align=middle width=9.075367949999992pt height=22.831056599999986pt/>-particle entangled if it can be written as a tensor product <img src="/tex/9a6a0f20f0fc6c95816cd745b745ad46.svg?invert_in_darkmode&sanitize=true" align=middle width=144.70084365pt height=27.6567522pt/>, where <img src="/tex/abe87f228577615a6de835b8b5b8f25e.svg?invert_in_darkmode&sanitize=true" align=middle width=56.68753199999998pt height=22.831056599999986pt/>, (<img src="/tex/0bdad6182d7535454478cc28423eb6bf.svg?invert_in_darkmode&sanitize=true" align=middle width=111.83413889999997pt height=32.256008400000006pt/>) is the number of particles (spins) in the <img src="/tex/62d9baf838ff4f7ef880a8a05fde9427.svg?invert_in_darkmode&sanitize=true" align=middle width=27.094918949999986pt height=27.91243950000002pt/> state and <img src="/tex/0180a951f100647f1e1e27a3849078ef.svg?invert_in_darkmode&sanitize=true" align=middle width=131.89890615pt height=27.6567522pt/> cannot be further factorized. 

The degree of multipartite entanglement can be inferred by means of the quantum Fisher information (QFI). This tool is originally developed in the context of quantum metrology to quantify the ultimate bound on precision that can be achieved in a parameter estimation procedure. If the parameter of interest is the amplitude of a unitary perturbation imposed to a given initial state <img src="/tex/6dec54c48a0438a5fcde6053bdb9d712.svg?invert_in_darkmode&sanitize=true" align=middle width=8.49888434999999pt height=14.15524440000002pt/> (so a transformation the form <img src="/tex/d70b04709ff5b59e888afe95b0006dbb.svg?invert_in_darkmode&sanitize=true" align=middle width=142.19452005pt height=33.72982469999997pt/>, the QFI can be written in a closed form as the variance of the Hermitinan generator <img src="/tex/a3f1ae33cad353141a4d09579d9b15c8.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=31.141535699999984pt/> over the state <img src="/tex/2ece8916c80529609c5cc5d5b4e259f4.svg?invert_in_darkmode&sanitize=true" align=middle width=9.728951099999989pt height=22.831056599999986pt/>: <img src="/tex/12373af930b22934f644baa646531e68.svg?invert_in_darkmode&sanitize=true" align=middle width=123.01301924999999pt height=31.141535699999984pt/>, and the variance of the estimator <img src="/tex/8a50a59977b03bf02253782e85bc7cad.svg?invert_in_darkmode&sanitize=true" align=middle width=23.90648699999999pt height=31.50689519999998pt/> is bounded by 

<img src="/tex/d33496d8f84420b917be44d449609b9a.svg?invert_in_darkmode&sanitize=true" align=middle width=127.6005258pt height=31.50689519999998pt/>. 

The connection between multipartite entanglement and the QFI for a system of <img src="/tex/ead28ce23668aee645f6001ea67bbc0f.svg?invert_in_darkmode&sanitize=true" align=middle width=56.278619099999986pt height=22.465723500000017pt/> can be established considering a phase shift generator of the form 

<img src="/tex/4b9158bb4bed0efb7d96ed510e82ac44.svg?invert_in_darkmode&sanitize=true" align=middle width=146.52694154999998pt height=32.256008400000006pt/>,

where <img src="/tex/333af16d4fa032e701e4088d5221d5b8.svg?invert_in_darkmode&sanitize=true" align=middle width=107.68869704999997pt height=24.65753399999998pt/> is a vector on the Bloch sphere and <img src="/tex/7a94df8e38a1764a3e1eb33d5c889213.svg?invert_in_darkmode&sanitize=true" align=middle width=117.45421874999998pt height=25.70766330000001pt/> is the vector of the Pauli matrices associated with the spin <img src="/tex/2f2322dff5bde89c37bcae4116fe20a8.svg?invert_in_darkmode&sanitize=true" align=middle width=5.2283516999999895pt height=22.831056599999986pt/>. This connection is given by the bound 

<img src="/tex/28f5e0b921f4f3c77eab6217b4e860f9.svg?invert_in_darkmode&sanitize=true" align=middle width=254.62473959999994pt height=31.141535699999984pt/>, 

where <img src="/tex/d78fd480dd8c7776dd798cc6bcab8e70.svg?invert_in_darkmode&sanitize=true" align=middle width=59.82635009999999pt height=28.670654099999997pt/>. Given a probe state <img src="/tex/6dec54c48a0438a5fcde6053bdb9d712.svg?invert_in_darkmode&sanitize=true" align=middle width=8.49888434999999pt height=14.15524440000002pt/>, if the bound is violated, then the probe state contains useful <img src="/tex/8efe9ff4209e9ab5e98c62cd39393f0e.svg?invert_in_darkmode&sanitize=true" align=middle width=50.17119689999999pt height=24.65753399999998pt/>-partite entanglement. So an operative procedure to estimate the degree of multipartite entanglement for a given state <img src="/tex/6dec54c48a0438a5fcde6053bdb9d712.svg?invert_in_darkmode&sanitize=true" align=middle width=8.49888434999999pt height=14.15524440000002pt/> is to calculate the QFI for a general operator of the form <img src="/tex/140bfa2d03cf23a59765e1dfc20687a2.svg?invert_in_darkmode&sanitize=true" align=middle width=28.36768604999999pt height=31.141535699999984pt/> and performing an optimization over the directions of the Bloch vectors <img src="/tex/6f45ca5fd64bf60875306301be83832e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/>.  

## Main functions 

This toolbox provides a range of functions for quantum information and entanglement analysis. Key functions include:
- `QFIEntanglementToolbox.bipartiteEntanglement` - Entropy of entanglement of a bipartite state.
- `QFIEntanglementToolbox.heisenbergXXZ` - one-dimensional XXZ spin-1/2 Heisenberg Hamiltonian.
- `QFIEntanglementToolbox.phaseShiftEnsemble` - ensemble of linear phase shift operators.
- `QFIEntanglementToolbox.phaseShiftGenerator` - linear phase shift operators for a specific Bloch sphere vector orientation.
- `QFIEntanglementToolbox.stateQFI` - estimated quantum Fisher information for a given input state.

Many other core functions (e.g., `GHZState`, `densityMatrix`, `PartialTrace`) and utility functions (e.g., `mKron`, `cleanMat` in the `QFIEntanglementToolbox.utils` package) are available. Consult the `Contents.m` files or the API documentation for a complete list.

## Dependencies

*   **MATLAB:** This toolbox is designed for use with MATLAB. While no specific version is strictly enforced, it has been developed using modern MATLAB features. Core MATLAB functionality is assumed.
*   **QETLAB-Inspired Utilities:** Several utility functions within this toolbox (primarily in `QFIEntanglementToolbox.utils` and some core functions like `PartialTrace`, `PermuteSystems`, etc.) are inspired by or adapted from QETLAB (http://www.qetlab.com). These are included directly in this toolbox to ensure self-containment and consistent behavior. Users do not need to install QETLAB separately for these specific, included functions to work.
*   **`TraceNorm` Function Requirement:** The function `QFIEntanglementToolbox.TraceNorm` (for calculating the trace norm) requires the MATLAB function `kpNorm.m`. This file is a part of QETLAB but is **not** included in this toolbox. For `TraceNorm` to function correctly, you must have `kpNorm.m` (typically obtained from a full QETLAB installation) available on your MATLAB path.
*   **Other Functions:** Standard MATLAB functions are used throughout. The function `de2bi` (used in `randomHeisenbergZ.m` and `zeroTotalSpinLabel.m`) is typically available in standard MATLAB installations or the Communications Toolbox.
