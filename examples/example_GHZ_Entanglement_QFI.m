%% Example: GHZ State, Bipartite Entanglement, and QFI Estimation
% This script demonstrates the generation of a Greenberger-Horne-Zeilinger (GHZ)
% state, calculation of its bipartite entanglement, and estimation of its
% Quantum Fisher Information (QFI) using the QFIEntanglementToolbox.

fprintf('--- Example: GHZ State, Entanglement, and QFI ---\n\n');

% --- 1. Generate a GHZ State ---
L = 4; % Number of qubits
fprintf('Generating a GHZ state for L = %d qubits...\n', L);
ghz_state = QFIEntanglementToolbox.GHZState(L);

% Display the generated state (optional, can be large for higher L)
% For L=4, the state vector has 2^4 = 16 elements.
fprintf('GHZ State (vector form for L=%d):\n', L);
disp(ghz_state);
fprintf('\n');

% --- 2. Calculate Bipartite Entanglement ---
% We will calculate the entanglement entropy for a bipartition A | B,
% where subsystem A consists of k qubits.
k = L/2; % Size of the first subsystem (A)
fprintf('Calculating bipartite entanglement S(A) for a partition with k = %d qubits in subsystem A...\n', k);
S_entanglement = QFIEntanglementToolbox.bipartiteEntanglement(ghz_state, k);

fprintf('Bipartite Entanglement S(A) = %.4f (for k=%d)\n', S_entanglement, k);
fprintf('\n');

% --- 3. Estimate Quantum Fisher Information (QFI) ---
% The QFI is estimated by optimizing over random measurement directions.
nBlochVec = 100; % Number of random Bloch vectors for the ensemble of generators
distr = 'uniform'; % Distribution of Bloch vectors on the sphere

fprintf('Estimating Quantum Fisher Information (QFI) for the GHZ state...\n');
fprintf('Using %d random Bloch vectors with a "%s" distribution.\n', nBlochVec, distr);

% For pure states like GHZ, QFI = 4 * variance(J) over the state.
% stateQFI calculates this by finding the maximum variance over an ensemble of J operators.
[maxF, varF, idx_max_F] = QFIEntanglementToolbox.stateQFI(ghz_state, nBlochVec, distr);

fprintf('Estimated QFI (F_Q) = %.4f\n', maxF);
fprintf('Variance of the QFI estimates over different generators = %.4f\n', varF);
fprintf('Index of the generator that yielded maxF = %d\n', idx_max_F);
fprintf('\n');

% Theoretical QFI for a GHZ state with J = (1/2) * sum(sigma_z_i) is L^2.
% Our stateQFI tries to find this optimal J by random search.
% For GHZ states, the QFI for the optimal measurement setting is indeed L^2.
fprintf('Theoretical maximum QFI for an L-qubit GHZ state is L^2 = %d^2 = %d.\n', L, L^2);
fprintf('The estimated value should be close to this, depending on nBlochVec and the random sampling.\n');

fprintf('\n--- End of Example ---\n');
