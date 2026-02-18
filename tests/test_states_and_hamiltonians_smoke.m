classdef test_states_and_hamiltonians_smoke < matlab.unittest.TestCase
    properties
        AbsTol = 1e-10;
    end

    methods (Test)
        function testStateConstructors(testCase)
            ghz = QFIEntanglementToolbox.GHZState(4);
            neel = QFIEntanglementToolbox.neelState(4);

            testCase.verifySize(ghz, [16 1]);
            testCase.verifySize(neel, [16 1]);
            testCase.verifyEqual(norm(ghz), 1, 'AbsTol', testCase.AbsTol);
            testCase.verifyEqual(norm(neel), 1, 'AbsTol', testCase.AbsTol);
        end

        function testHeisenbergShapeAndHermiticity(testCase)
            h = QFIEntanglementToolbox.heisenbergXXZ(3, 1.0);
            testCase.verifySize(h, [8 8]);
            testCase.verifyTrue(issparse(h));
            testCase.verifyEqual(full(h), full(h'), 'AbsTol', testCase.AbsTol);
        end

        function testBoundQFISmoke(testCase)
            b = QFIEntanglementToolbox.boundQFI(6);
            testCase.verifySize(b, [1 6]);
            testCase.verifyTrue(all(b >= 0));
        end

        function testRandomHeisenbergJShape(testCase)
            h = QFIEntanglementToolbox.randomHeisenbergJ(3, 1.0, 0.8);
            testCase.verifySize(h, [8 8]);
            testCase.verifyEqual(full(h), full(h'), 'AbsTol', testCase.AbsTol);
        end
    end
end
