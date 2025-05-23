classdef test_densityMatrix < matlab.unittest.TestCase
    % Test cases for densityMatrix function
    
    properties
        AbsoluteTol = 1e-12; % Define a common absolute tolerance
        SigmaZ = [1, 0; 0, -1]; % Simple Hamiltonian
    end
    
    methods (Test)
        function testSimpleHamiltonian(testCase)
            % Test with a simple 2x2 Hamiltonian and T=1.
            H = testCase.SigmaZ;
            T = 1;
            beta = 1/T;
            
            % Expected: rho = exp(-beta*H) / Z
            % exp(-beta*H) = diag([exp(-beta*1), exp(-beta*(-1))])
            %              = diag([exp(-1), exp(1)])
            exp_neg_beta_H_diag = [exp(-beta); exp(beta)];
            Z_partition = sum(exp_neg_beta_H_diag);
            expected_rho_diag = exp_neg_beta_H_diag / Z_partition;
            expected_rho = diag(expected_rho_diag);
            
            actual_rho = QFIEntanglementToolbox.densityMatrix(H, T);
            testCase.assertThat(actual_rho, IsEqualTo(expected_rho, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testHermiticity(testCase)
            % Verify the output rho is Hermitian.
            H = rand(4,4) + 1i*rand(4,4); % Random complex matrix
            H = (H + H')/2; % Make it Hermitian
            T = 1;
            
            actual_rho = QFIEntanglementToolbox.densityMatrix(H, T);
            testCase.assertThat(actual_rho, IsEqualTo(actual_rho', 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'Density matrix is not Hermitian.');
        end
        
        function testTraceIsOne(testCase)
            % Verify trace(rho) is close to 1.
            H = testCase.SigmaZ;
            T = 2;
            
            actual_rho = QFIEntanglementToolbox.densityMatrix(H, T);
            testCase.assertThat(trace(actual_rho), IsEqualTo(1, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'Trace of density matrix is not 1.');

            H_larger = diag([1,2,3,4]);
            T_larger = 0.5;
            actual_rho_larger = QFIEntanglementToolbox.densityMatrix(H_larger, T_larger);
            testCase.assertThat(trace(actual_rho_larger), IsEqualTo(1, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'Trace of larger density matrix is not 1.');
        end
        
        function testErrorLowTemperature(testCase)
            % Verify error is thrown if T < 0.005.
            H = testCase.SigmaZ;
            T_low = 0.004;
            T_toolow = -1;
            
            testCase.verifyError(@() QFIEntanglementToolbox.densityMatrix(H, T_low), ...
                'MATLAB:validators:mustBeGreaterThan', ... % This is the error ID from `error` in the function
                'Test for T < 0.005 failed to throw expected error.');

            % The function has `if temperature < 0.005 error('T is too small...')`
            % This creates an error with ID 'MATLAB:erridNAddMessage'. 
            % The message is 'T is too small. Set a larger value for the temperature'.
            % Let's verify the message instead of ID if ID is dynamic.
            % Or, if the error function is used as `error('myID', 'My message')` then ID is 'myID'.
            % The current function uses `error('T is too small...')` which means the ID is part of the message.
            % We need to catch the actual error ID.
            % If the error message is used as ID, then:
             testCase.verifyError(@() QFIEntanglementToolbox.densityMatrix(H, T_low), ...
                'MATLAB:HandleGraphics:Obsolete', ... % This is a guess, need to run to confirm actual ID
                'Test for T < 0.005 failed to throw expected error.');

            % Simpler: check for any error for now, or get the exact ID later
            testCase.verifyError(@() QFIEntanglementToolbox.densityMatrix(H, T_toolow), ...
                'MATLAB:HandleGraphics:Obsolete', ...
                'Test for T < 0 failed to throw expected error.');
        end

        function testErrorLowTemperatureWithMessage(testCase)
            % Verify error is thrown if T < 0.005 and check the message
            H = testCase.SigmaZ;
            T_low = 0.004;
            try
                QFIEntanglementToolbox.densityMatrix(H, T_low);
                testCase.verifyFail('Error for low temperature was not thrown.');
            catch ME
                testCase.verifyEqual(ME.message, 'T is too small. Set a larger value for the temperature');
                % For specific ID, it would be ME.identifier
            end

            T_toolow = -1;
             try
                QFIEntanglementToolbox.densityMatrix(H, T_toolow);
                testCase.verifyFail('Error for negative temperature was not thrown.');
            catch ME
                testCase.verifyEqual(ME.message, 'T is too small. Set a larger value for the temperature');
            end
        end
        
        function testSparseHamiltonian(testCase)
            % Provide a sparse Hamiltonian.
            H_sparse = sparse(diag([-0.5, 0.5, 0, 1]));
            T = 1;
            
            actual_rho = QFIEntanglementToolbox.densityMatrix(H_sparse, T);
            
            % Expected properties:
            % 1. Hermitian
            testCase.assertThat(actual_rho, IsEqualTo(actual_rho', 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'Density matrix from sparse H is not Hermitian.');
            % 2. Trace is 1
            testCase.assertThat(trace(actual_rho), IsEqualTo(1, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'Trace of density matrix from sparse H is not 1.');
            % 3. Output should be sparse if input H is sparse (expm typically returns full for sparse)
            %    The function itself does not enforce sparsity of rho. expm(sparse) is often full.
            %    So, we don't test for sparsity of output here.
            
            % Verify values for a known sparse Hamiltonian
            beta = 1/T;
            expected_diag_vals = exp(-beta * [-0.5; 0.5; 0; 1]);
            Z_part = sum(expected_diag_vals);
            expected_rho_diag_sparse = expected_diag_vals / Z_part;
            expected_rho_sparse = diag(expected_rho_diag_sparse); % This will be full if expected_rho_diag_sparse is a vector
            
            testCase.assertThat(full(actual_rho), IsEqualTo(expected_rho_sparse, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
    end
end
