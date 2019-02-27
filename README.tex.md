#	Quantum Fisher information Toolbox 
This repository contains is a toolbox for exploring and manipulating multipartite entanglement and quantum Fisher information.
## Theoretical background
Given a pure quantum state $|\psi>$, we say that $|\psi>$ is $k$-particle entangled if it can be written as a tensor product $|\psi>= \otimes_{m=1}^M|\phi>_m^{N_m}$, where $N_m \leq k$, ($\sum_{m=1}^M N_m = N$) is the number of particles (spins) in the $m^{th}$ state and $\{|\phi_m^{N_m}>\}_{m = 1,\dotsc,M}$ cannot be further factorized. 

The degree of multipartite entanglement can be inferred by means of the quantum Fisher information (QFI). This tool is originally developed in the context of quantum metrology to quantify the ultimate bound on precision that can be achieved in a parameter estimation procedure. If the parameter of interest is the amplitude of a unitary perturbation imposed to a given initial state $\rho$ (so a transformation the form $\rho(\theta) = e^{-i\theta\hat{H}}\rho e^{+i\theta\hat{H}}$, the QFI can be written in a closed form as the variance of the Hermitinan generator $\hat{H}$ over the state $\hat{\rho}$: $F[\hat{\rho},\hat{H}] = (\Delta\hat{H})^2_{\rho}$, and the variance of the estimator $\hat{\theta}_{\text{est}}$ is bounded by 

$\Delta\hat{\theta}_{\text{est}} \geq \frac{1}{\sqrt{m F[\rho,\hat{H}]}}$. 

The connection between multipartite entanglement and the QFI for a system of $N\text{-spins}$ can be established considering a phase shift generator of the form 

$\hat{H}_{\text{lin}} = \frac{1}{2}\sum_{l = 1}^N \bm{n}_l\cdot\hat{\bm{\sigma}}_l$,

where $\bm{n}_l \equiv (\alpha_l,\beta_l,\gamma_l)$ is a vector on the Bloch sphere and $\hat{\bm{\sigma}}_l = (\hat{\sigma}^x_l,\hat{\sigma}^y_l,\hat{\sigma}^z_l)$ is the vector of the Pauli matrices associated with the spin $l$. This connection is given by the bound 

$F_Q[\rho_{k\text{-prod}},\hat{H}_{lin}] \leq sk^2 + (N - sk)^2$, 

where $s = \lfloor\frac{N}{k}\rfloor$. Given a probe state $\rho$, if the bound is violated, then the probe state contains useful $(k+1)$-partite entanglement. So an operative procedure to estimate the degree of multipartite entanglement for a given state $\rho$ is to calculate the QFI for a general operator of the form $\hat{H}_\text{lin}$ and performing an optimization over the directions of the Bloch vectors $\bm{n}$.  

## Main functions 

- `bipartiteEntanglement.m` -  Entropy of entanglement of a bipartite state.
- `heisenbergXXZ.m` -  one-dimensional XXZ spin-1/2 Heisenberg Hamiltonian.
- `phaseShiftEnsemble.m`- ensemble of linear phase shift operators.
- `phaseShiftGenerator.m`-  linear phase shift operators for a specific Bloch sphere vector orientation.
- `stateQFI.m`- estimated quantum Fisher information for a given input state
