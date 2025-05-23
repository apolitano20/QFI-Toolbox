%% Example: Heisenberg XXZ Model and Local Magnetization
% This script demonstrates how to construct a Heisenberg XXZ Hamiltonian
% and then calculate the local magnetization for a given test state (e.g., GHZ state)
% using the QFIEntanglementToolbox.

fprintf('--- Example: Heisenberg XXZ Model and Local Magnetization ---\n\n');

% --- 1. Define Parameters and Construct Heisenberg XXZ Hamiltonian ---
L_heis = 4; % Number of qubits (sites) in the spin chain
delta = 1.0;  % Anisotropy parameter (delta = 1 corresponds to the XXX model)

fprintf('Constructing the Heisenberg XXZ Hamiltonian for L = %d and delta = %.2f...\n', L_heis, delta);
H_xxz = QFIEntanglementToolbox.heisenbergXXZ(L_heis, delta);

% Display the Hamiltonian (for small L, using full() if sparse)
fprintf('Heisenberg XXZ Hamiltonian (L=%d, delta=%.2f):\n', L_heis, delta);
if L_heis <= 4 % Only display for small systems to avoid clutter
    disp(full(H_xxz));
else
    fprintf('(Hamiltonian is too large to display for L=%d)\n', L_heis);
end
fprintf('\n');

% --- 2. Choose a Test State for Magnetization Calculation ---
% For simplicity, instead of finding the ground state of H_xxz,
% we will use a known state. Let's use a GHZ state.
fprintf('Generating a GHZ state for L = %d to calculate its local magnetization...\n', L_heis);
test_state = QFIEntanglementToolbox.GHZState(L_heis);
% Alternatively, one could use a Neel state:
% test_state = QFIEntanglementToolbox.neelState(L_heis);
% fprintf('Using a Neel state for magnetization calculation.\n');

fprintf('Test State (GHZ state for L=%d):\n', L_heis);
if L_heis <= 4
    disp(test_state);
else
    fprintf('(State vector is too large to display for L=%d)\n', L_heis);
end
fprintf('\n');
disp('Note: The constructed H_xxz is not used to find a ground state in this example; we are using a predefined test state.');
fprintf('\n');

% --- 3. Calculate Local Magnetization ---
fprintf('Calculating local magnetization for the test state...\n');
Mag = QFIEntanglementToolbox.localMagnetization(test_state);

% Display the magnetization results
% Mag is an L x 3 matrix: Mag(i,1)=<Sx_i>, Mag(i,2)=<Sy_i>, Mag(i,3)=<Sz_i>
fprintf('Local Magnetization (columns: <Sx>, <Sy>, <Sz>) for each site (rows):\n');
disp(Mag);
fprintf('\n');

% Interpretation for a GHZ state like |00...0> + |11...1> / sqrt(2):
% - Expect <Sx_i> = 0 and <Sy_i> = 0 for all sites due to symmetry.
% - Expect <Sz_i> values to be non-zero if L=1, but for L>1, the GHZ state is a superposition.
%   For |00>+|11 /sqrt(2), rho_i = I/2, so <S_alpha_i> = 0.
%   Let's check the math for GHZ. For any site i, tracing out others gives I/2.
%   So, <S_alpha_i> = Tr( (I/2) * S_alpha ) = 0 for traceless S_alpha (Sx, Sy, Sz).
%   The localMagnetization function calculates state' * S_operator * state.
%   For GHZ = (|0...0> + |1...1>)/sqrt(2)
%   <Sz_i> = (1/2) * (<0...0|Sz_i|0...0> + <1...1|Sz_i|1...1> + <0...0|Sz_i|1...1> + <1...1|Sz_i|0...0>)
%   <0...0|Sz_i|0...0> = 1/2 (spin up at site i)
%   <1...1|Sz_i|1...1> = -1/2 (spin down at site i)
%   Off-diagonal terms are zero because Sz_i doesn't flip all spins.
%   So, <Sz_i> = (1/2) * (1/2 - 1/2) = 0.
%   This means for a GHZ state, all local magnetizations should be 0.

fprintf('Note: For an ideal GHZ state (|0...0> + |1...1>)/sqrt(2), the expectation value of Sx, Sy, and Sz for any single site is 0.\n');
fprintf('The results should be close to zero, subject to numerical precision.\n');

fprintf('\n--- End of Example ---\n');
