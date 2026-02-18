classdef test_qfi_smoke < matlab.unittest.TestCase
    properties
        AbsTol = 1e-9;
    end

    methods (Test)
        function testStateQFIManualSingleConfig(testCase)
            psi = QFIEntanglementToolbox.GHZState(2);
            elevation = zeros(2,1);
            azimuth = (pi/2) * ones(2,1);

            [maxF, varF, idx, allF] = QFIEntanglementToolbox.stateQFIManual(psi, elevation, azimuth);
            testCase.verifyGreaterThanOrEqual(maxF, 0);
            testCase.verifyGreaterThanOrEqual(varF, 0);
            testCase.verifyEqual(idx, 1);
            testCase.verifySize(allF, [1 1]);
        end

        function testStateQFISmoke(testCase)
            psi = QFIEntanglementToolbox.GHZState(3);
            [maxF, varF, idx] = QFIEntanglementToolbox.stateQFI(psi, 3, 'uniform');

            testCase.verifyGreaterThanOrEqual(maxF, 0);
            testCase.verifyGreaterThanOrEqual(varF, 0);
            testCase.verifyGreaterThanOrEqual(idx, 1);
        end

        function testRhoQFISmoke(testCase)
            psi = QFIEntanglementToolbox.GHZState(2);
            rho = psi * psi';
            [maxF, varF] = QFIEntanglementToolbox.rhoQFI(rho, 2, 'uniform');

            testCase.verifyGreaterThanOrEqual(maxF, 0);
            testCase.verifyGreaterThanOrEqual(varF, 0);
            testCase.verifyClass(maxF, 'double');
            testCase.verifyClass(varF, 'double');
        end
    end
end
