classdef test_cleanMat < matlab.unittest.TestCase
    % Test cases for cleanMat function
    
    properties
        AbsoluteTol = 1e-12; % Define a common absolute tolerance
    end
    
    methods (Test)
        function testSmallValuesZeroed(testCase)
            % Test if values smaller than epsilon become zero.
            m = [0.01, 0.001, 0.0001];
            epsilon = 0.005;
            expected = [0.01, 0, 0];
            actual = QFIEntanglementToolbox.utils.cleanMat(m, epsilon);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
            
            m_col = m';
            expected_col = expected';
            actual_col = QFIEntanglementToolbox.utils.cleanMat(m_col, epsilon);
            testCase.assertThat(actual_col, IsEqualTo(expected_col, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testNearValuesUnified(testCase)
            % Test if values whose relative difference is smaller than epsilon are unified.
            % The original cleanMat logic for unifying is:
            % if abs(m(iRow,iCol) - m(jRow,iCol)) < epsilon, m(jRow,iCol) = m(iRow,iCol);
            % This means the second encountered value is set to the first one it's close to.
            m = [1.000, 1.001, 1.002, 1.500, 1.501];
            epsilon = 0.0015; % Values within 0.0015 of each other
            % Expected: 1.000, 1.000 (close to 1.000), 1.000 (close to 1.000), 1.500, 1.500 (close to 1.500)
            % The loop structure matters:
            % For iCol = 1:
            %  iRow = 1 (m(1,1)=1.000):
            %   jRow = 1: no change
            %   jRow = 2 (m(2,1)=1.001): abs(1.000 - 1.001) = 0.001 < 0.0015. m(2,1) = 1.000. Matrix: [1.000; 1.000; 1.002; 1.500; 1.501]
            %   jRow = 3 (m(3,1)=1.002): abs(1.000 - 1.002) = 0.002 > 0.0015. No change by this.
            %  iRow = 2 (m(2,1)=1.000 now):
            %   jRow = 1: abs(1.000 - 1.000) = 0 < 0.0015. m(1,1) = 1.000.
            %   jRow = 2: no change
            %   jRow = 3 (m(3,1)=1.002): abs(1.000 - 1.002) = 0.002 > 0.0015. No change.
            %  iRow = 3 (m(3,1)=1.002):
            %   jRow = 1 (m(1,1)=1.000): abs(1.002-1.000) = 0.002 > 0.0015.
            %   jRow = 2 (m(2,1)=1.000): abs(1.002-1.000) = 0.002 > 0.0015.
            % ... this implies a specific processing order.
            % Let's test with a simpler case based on the example.
            % >>outM = cleanMat([0.2, 0.3, 1.5, 1.7],0.5) -> outM = [0, 0, 1.5, 1.5]
            % First step: m(abs(m) < eps) = 0; -> [0, 0, 1.5, 1.7] (assuming eps=0.5)
            % Then unification:
            % iCol=1, iRow=3 (val=1.5), jRow=4 (val=1.7). abs(1.5-1.7)=0.2 < 0.5. m(4,1)=1.5. So [0,0,1.5,1.5]
            
            m_example = [0.2, 0.3, 1.5, 1.7];
            epsilon_example = 0.5;
            expected_example = [0, 0, 1.5, 1.5]; % First pass zeros out 0.2 and 0.3. Then 1.7 becomes 1.5.
            actual_example = QFIEntanglementToolbox.utils.cleanMat(m_example, epsilon_example);
            testCase.assertThat(actual_example, IsEqualTo(expected_example, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));

            m_complex = [1.0 + 1.0i, 1.001 + 1.001i, 1.5 + 1.5i];
            epsilon_complex = 0.002; % sqrt(0.001^2 + 0.001^2) approx 0.001414
            % After zeroing (if any, none here for this epsilon)
            % Then unification: abs((1+i) - (1.001+1.001i)) = abs(-0.001-0.001i) = sqrt(2e-6) approx 0.001414 < 0.002
            % So, m(2) becomes m(1).
            expected_complex = [1.0 + 1.0i, 1.0 + 1.0i, 1.5 + 1.5i];
            actual_complex = QFIEntanglementToolbox.utils.cleanMat(m_complex, epsilon_complex);
            testCase.assertThat(actual_complex, IsEqualTo(expected_complex, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testNoChangeNeeded(testCase)
            % Test matrix that should remain unchanged.
            m = [1, 2, 3; 4, 5, 6];
            epsilon = 0.0001;
            expected = m;
            actual = QFIEntanglementToolbox.utils.cleanMat(m, epsilon);
            testCase.assertThat(actual, IsEqualTo(expected, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
        
        function testEmptyMatrix(testCase)
            % Test with an empty matrix.
            m = [];
            epsilon = 0.1;
            expected = [];
            actual = QFIEntanglementToolbox.utils.cleanMat(m, epsilon);
            testCase.assertEqual(actual, expected);
        end
        
        function testComplexNumbers(testCase)
            % Test with complex numbers for zeroing and unification.
            m_zeroing = [0.001 + 0.002i, 0.5 + 0.5i];
            epsilon_zeroing = 0.003; % sqrt(0.001^2+0.002^2) = sqrt(5e-6) approx 0.00223 < 0.003
            expected_zeroing = [0 + 0i, 0.5 + 0.5i];
            actual_zeroing = QFIEntanglementToolbox.utils.cleanMat(m_zeroing, epsilon_zeroing);
            testCase.assertThat(actual_zeroing, IsEqualTo(expected_zeroing, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
            
            m_unify = [1+1i, 1.0001+1.0001i, 2+2i, 2.0001+2.0002i];
            epsilon_unify = 0.00015; 
            % abs( (1+1i) - (1.0001+1.0001i) ) = abs(-0.0001-0.0001i) = sqrt(2e-8) approx 0.0001414 < 0.00015
            % -> 1.0001+1.0001i becomes 1+1i
            % abs( (2+2i) - (2.0001+2.0002i) ) = abs(-0.0001-0.0002i) = sqrt(1e-8+4e-8) = sqrt(5e-8) approx 0.00022 > 0.00015
            expected_unify = [1+1i, 1+1i, 2+2i, 2.0001+2.0002i];
            actual_unify = QFIEntanglementToolbox.utils.cleanMat(m_unify, epsilon_unify);
            testCase.assertThat(actual_unify, IsEqualTo(expected_unify, 'Within', AbsoluteTolerance(testCase.AbsoluteTol)));
        end
    end
end
