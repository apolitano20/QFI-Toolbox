classdef test_GHZState < matlab.unittest.TestCase
    % Test cases for GHZState function
    
    properties
        AbsoluteTol = 1e-12; % Define a common absolute tolerance
    end
    
    methods (Test)
        function testGHZStateL2(testCase)
            % Test for L=2. Expected: [1;0;0;1]/sqrt(2)
            L = 2;
            expected_state = [1; 0; 0; 1] / sqrt(2);
            actual_state = QFIEntanglementToolbox.GHZState(L);
            testCase.assertThat(actual_state, IsEqualTo(expected_state, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testGHZStateL3(testCase)
            % Test for L=3. Expected: [1;0;0;0;0;0;0;1]/sqrt(2)
            L = 3;
            dim = 2^L;
            expected_state = zeros(dim, 1);
            expected_state(1) = 1;
            expected_state(dim) = 1;
            expected_state = expected_state / sqrt(2);
            actual_state = QFIEntanglementToolbox.GHZState(L);
            testCase.assertThat(actual_state, IsEqualTo(expected_state, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testNormalization(testCase)
            % Test if the GHZ state is normalized for various L.
            for L = 2:5 % Test a few reasonable values for L
                ghz_state = QFIEntanglementToolbox.GHZState(L);
                testCase.assertThat(norm(ghz_state), IsEqualTo(1, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                    sprintf('Normalization failed for L=%d', L));
            end
        end
        
        function testInvalidL(testCase)
            % GHZ states are typically defined for L >= 2 (for multipartite entanglement).
            % The function itself might allow L=1 (result [1;1]/sqrt(2)), 
            % but this isn't usually called a GHZ state in the same context.
            % Let's test for L=1 based on its current implementation: 2^1 dim, first and last are 1.
            % For L=1, dim = 2. tmpVec = [1;1]. ghzState = [1;1]/sqrt(2).
            
            L1_state = QFIEntanglementToolbox.GHZState(1);
            expected_L1 = [1;1]/sqrt(2);
            testCase.assertThat(L1_state, IsEqualTo(expected_L1, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'GHZState for L=1 did not match expected [1;1]/sqrt(2).');

            % Test for L=0. This should ideally error or be handled gracefully.
            % Current GHZState function: dim = 2^0 = 1. tmpVec = zeros(1,1). tmpVec([1,end]) means tmpVec(1)=1.
            % So, ghzState = 1/sqrt(2). This is a scalar.
            L0_state = QFIEntanglementToolbox.GHZState(0);
            expected_L0 = 1/sqrt(2);
             testCase.assertThat(L0_state, IsEqualTo(expected_L0, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)), ...
                'GHZState for L=0 did not match expected 1/sqrt(2).');

            % Non-integer L should error due to 2^L.
            testCase.verifyError(@() QFIEntanglementToolbox.GHZState(2.5), ...
                'MATLAB:exponent:nonIntegerExponents', ...
                'Test for non-integer L failed to throw expected error.');
            
            % Negative L should error
            testCase.verifyError(@() QFIEntanglementToolbox.GHZState(-1), ...
                'MATLAB:exponent:nonIntegerExponents', % Or similar depending on how 2^L handles it.
                                                       % Negative powers are fine, but result in non-integer dim for zeros()
                                                       % Let's see what error `zeros` would throw with 2^-1 = 0.5
                'Test for negative L failed to throw expected error.'); 
                % The error for `zeros(0.5,1)` is 'MATLAB:expectedInteger'
                % Let's refine the negative L test if the specific error ID for 2^L is different.
                % Actually, 2^(-1) is valid for `zeros`. `zeros(0.5,1)` would error.
                % The function uses `dim = 2^numQubits; tmpVec = zeros(dim,1);`
                % If numQubits = -1, dim = 0.5. `zeros(0.5,1)` errors with 'MATLAB:expectedInteger'.
        end

         function testNegativeLStrict(testCase)
            % Test negative L specifically for the error from zeros function
            testCase.verifyError(@() QFIEntanglementToolbox.GHZState(-1), 'MATLAB:expectedInteger', ...
                'Test for L=-1 did not throw MATLAB:expectedInteger from zeros().');
            testCase.verifyError(@() QFIEntanglementToolbox.GHZState(-2), 'MATLAB:expectedInteger', ...
                'Test for L=-2 did not throw MATLAB:expectedInteger from zeros().');
        end

    end
end
