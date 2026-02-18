classdef test_linear_algebra_smoke < matlab.unittest.TestCase
    properties
        AbsTol = 1e-12;
    end

    methods (Test)
        function testPartialTraceBellState(testCase)
            psi = [1;0;0;1] / sqrt(2);
            rho = psi * psi';

            reduced = QFIEntanglementToolbox.PartialTrace(rho, 2, [2 2]);
            testCase.verifyEqual(reduced, 0.5 * eye(2), 'AbsTol', testCase.AbsTol);
        end

        function testPartialTransposePreservesTrace(testCase)
            psi = [1;0;0;1] / sqrt(2);
            rho = psi * psi';

            rhoPT = QFIEntanglementToolbox.PartialTranspose(rho, 2, [2 2]);
            testCase.verifyEqual(trace(rhoPT), trace(rho), 'AbsTol', testCase.AbsTol);
        end

        function testPermuteSystemsOnVector(testCase)
            v = (1:8)';
            out = QFIEntanglementToolbox.PermuteSystems(v, [2 1 3], [2 2 2]);
            testCase.verifySize(out, [8 1]);
            testCase.verifyEqual(sort(out), sort(v));
        end

        function testTraceDistanceIdentity(testCase)
            psi = QFIEntanglementToolbox.GHZState(3);
            d = QFIEntanglementToolbox.traceDistance(psi, psi);
            testCase.verifyEqual(d, 0, 'AbsTol', testCase.AbsTol);
        end

        function testTraceNormNumeric(testCase)
            op = [3 0; 0 -4];
            n = QFIEntanglementToolbox.traceNorm(op);
            testCase.verifyEqual(n, 7, 'AbsTol', testCase.AbsTol);
        end
    end
end
