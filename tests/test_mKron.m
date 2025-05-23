classdef test_mKron < matlab.unittest.TestCase
    % Test cases for mKron function
    
    properties
        AbsoluteTol = 1e-12; % Define a common absolute tolerance
        PauliX = [0, 1; 1, 0];
        PauliY = [0, -1i; 1i, 0];
        PauliZ = [1, 0; 0, -1];
        Identity2 = eye(2);
    end
    
    methods (Test)
        function testTwoMatrices(testCase)
            % Test Kronecker product of two known small matrices.
            A = testCase.PauliX;
            B = testCase.PauliY;
            expected = kron(A, B);
            actual = QFIEntanglementToolbox.utils.mKron(A, B);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testThreeMatrices(testCase)
            % Test Kronecker product of three known small matrices.
            A = testCase.PauliX;
            B = testCase.PauliY;
            C = testCase.PauliZ;
            expected = kron(kron(A, B), C);
            actual = QFIEntanglementToolbox.utils.mKron(A, B, C);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testIdentityMatrices(testCase)
            % Test mKron(I,A) and mKron(A,I).
            A = testCase.PauliZ;
            I = testCase.Identity2;
            
            expected_IA = kron(I, A);
            actual_IA = QFIEntanglementToolbox.utils.mKron(I, A);
            testCase.assertThat(actual_IA, IsEqualTo(expected_IA, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
            
            expected_AI = kron(A, I);
            actual_AI = QFIEntanglementToolbox.utils.mKron(A, I);
            testCase.assertThat(actual_AI, IsEqualTo(expected_AI, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testOutputDimensions(testCase)
            % Verify the dimensions of the output matrix.
            A1 = rand(2,2);
            A2 = rand(3,3);
            A3 = rand(4,4);
            
            actual_two = QFIEntanglementToolbox.utils.mKron(A1, A2);
            expected_dim_two = [size(A1,1)*size(A2,1), size(A1,2)*size(A2,2)];
            testCase.assertEqual(size(actual_two), expected_dim_two);
            
            actual_three = QFIEntanglementToolbox.utils.mKron(A1, A2, A3);
            expected_dim_three = [size(A1,1)*size(A2,1)*size(A3,1), size(A1,2)*size(A2,2)*size(A3,2)];
            testCase.assertEqual(size(actual_three), expected_dim_three);
        end

        function testSingleArgument(testCase)
            % Test mKron with a single matrix argument.
            A = testCase.PauliX;
            expected = A; % kron(1, A) is A
            actual = QFIEntanglementToolbox.utils.mKron(A);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end

        function testNonSquareMatrices(testCase)
            A = [1 2 3; 4 5 6]; % 2x3
            B = [1; 2; 3];      % 3x1
            expected = kron(A,B);
            actual = QFIEntanglementToolbox.utils.mKron(A,B);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
            
            expected_dims = [size(A,1)*size(B,1), size(A,2)*size(B,2)];
            testCase.assertEqual(size(actual), expected_dims);
        end
    end
end
