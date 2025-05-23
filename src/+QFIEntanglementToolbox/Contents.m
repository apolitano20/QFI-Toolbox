% QFIENTANGLEMENTTOOLBOX Core quantum information and entanglement functions.
%
% Functions:
%   GHZState                   - Generates a Greenberger–Horne–Zeilinger (GHZ) state
%   JordanWignerTransformation - Jordan-Wigner transformation for a L-sites spin chain
%   PartialTrace               - Computes the partial trace of a matrix
%   PartialTranspose           - Computes the partial transpose of a matrix
%   PermuteSystems             - Permutes subsystems within a state or operator
%   bipartiteEntanglement      - Computes the entanglement entropy of a quantum state
%   boundQFI                   - Computes the the bound values for the multipartite entanglement
%   densityMatrix              - Returns the density matrix \rho = exp(-\beta H)
%   entropy                    - Computes the von Neumann entropy of a density matrix
%   heisenbergXXZ              - Returns the Heisenberg XXZ model Hamiltonian
%   localMagnetization         - Computes the local expectation value over the input state of the x,y and z components of each spin site.
%   multipartEntanglement      - returns the amount of MPE given the amount of QFI
%   neelState                  - Generates a Néel state
%   orderParameter             - returns the order parameter for a spin chain in the state |inputState>
%   phaseShiftEnsemble         - returns an ensemble of phase shift generator operators
%   phaseShiftGenerator        - returns a phase shift generator operator 
%   pureToMixed                - Converts a state vector or density matrix representation of a state to a density matrix
%   randomHeisenbergJ          - Returns the XXZ Heisenberg model Hamiltonian with random interaction strengts
%   randomHeisenbergZ          - Returns a random filed along the z direction
%   rhoQFI                     - Estimates the quantum Fisher information of a density matrix \rho
%   stateEvolution             - returns the time evolution of the input state under the input Hamiltonian
%   stateQFI                   - returns the estimate QFI for the input state |inputState>
%   stateQFIManual             - returns the QFI for the input state |inputState> and a given phase shift generator
%   tensorSum                  - Computes a vector or operator from its tensor decomposition
%   traceDistance              - Computes the the trace distance between the two input states |statePsi> and |statePhi>
%   traceNorm                  - Computes the trace norm of an operator
%   zeroTotalSpinLabel         - returns the label of the states in the computational base having zero total spin
