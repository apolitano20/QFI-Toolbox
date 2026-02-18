classdef test_wrapper_parity < matlab.unittest.TestCase
    properties
        AbsTol = 1e-12;
    end

    methods (Test)
        function testGhZWrapperWarningAndParity(testCase)
            testCase.verifyWarning(@() GHZState(3), 'QFIEntanglementToolbox:DeprecatedRootAPI');

            warnState = warning('off', 'QFIEntanglementToolbox:DeprecatedRootAPI');
            cleanup = onCleanup(@() warning(warnState)); %#ok<NASGU>

            legacy = GHZState(3);
            canonical = QFIEntanglementToolbox.GHZState(3);
            testCase.verifyEqual(legacy, canonical, 'AbsTol', testCase.AbsTol);
        end

        function testMkronWrapperParity(testCase)
            testCase.verifyWarning(@() mkron([1 2; 3 4], eye(2)), 'QFIEntanglementToolbox:DeprecatedRootAPI');

            warnState = warning('off', 'QFIEntanglementToolbox:DeprecatedRootAPI');
            cleanup = onCleanup(@() warning(warnState)); %#ok<NASGU>

            a = [1 2; 3 4];
            b = [0 1; 1 0];
            legacy = mkron(a, b);
            canonical = QFIEntanglementToolbox.utils.mKron(a, b);
            testCase.verifyEqual(legacy, canonical, 'AbsTol', testCase.AbsTol);
        end

        function testStateQFIManualAliasParity(testCase)
            psi = QFIEntanglementToolbox.GHZState(2);
            elevation = zeros(2,1);
            azimuth = (pi/2) * ones(2,1);

            warnState = warning('off', 'QFIEntanglementToolbox:DeprecatedRootAPI');
            cleanup = onCleanup(@() warning(warnState)); %#ok<NASGU>

            [m1,v1,i1,f1] = stateQFImanual(psi, elevation, azimuth);
            [m2,v2,i2,f2] = QFIEntanglementToolbox.stateQFIManual(psi, elevation, azimuth);

            testCase.verifyEqual(m1, m2, 'AbsTol', testCase.AbsTol);
            testCase.verifyEqual(v1, v2, 'AbsTol', testCase.AbsTol);
            testCase.verifyEqual(i1, i2);
            testCase.verifyEqual(f1, f2, 'AbsTol', testCase.AbsTol);
        end
    end
end
