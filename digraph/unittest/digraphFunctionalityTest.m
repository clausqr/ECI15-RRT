classdef digraphFunctionalityTest < matlab.unittest.TestCase
%DIGRAPHFUNCTIONALITYTEST Unit-test for DIGRAPH functionality.
%
% Run by executing
%   run(DIGRAPHFUNCTIONALITYTEST)

% Copyright 2014 The MathWorks, Inc.
    
    methods(Test)
        
        %------------------------------------------------------------------
        function Vertex(testCase)
            
            dg = digraph();
            testCase.verifyEqual(dg.NumVertices,0);
            testCase.verifyEmpty(dg.Vertex);
            testCase.verifyFalse(dg.hasVertex('A'));
            testCase.verifyFalse(dg.hasVertex('B'));
            
            dg.addVertex('A');
            testCase.verifyEqual(dg.NumVertices,1);
            testCase.verifyEqual(dg.Vertex,{'A'});
            testCase.verifyTrue(dg.hasVertex('A'));
            testCase.verifyFalse(dg.hasVertex('B'));
            
            % add A again, should get same results without error
            dg.addVertex('A');
            testCase.verifyEqual(dg.NumVertices,1);
            testCase.verifyEqual(dg.Vertex,{'A'});
            testCase.verifyTrue(dg.hasVertex('A'));
            testCase.verifyFalse(dg.hasVertex('B'));
            
            dg.addVertex('B');
            testCase.verifyEqual(dg.NumVertices,2);
            testCase.verifyEqual(dg.Vertex,{'A','B'});
            testCase.verifyTrue(dg.hasVertex('A'));
            testCase.verifyTrue(dg.hasVertex('B'));
            
            dg.removeVertex('A');
            testCase.verifyEqual(dg.NumVertices,1);
            testCase.verifyEqual(dg.Vertex,{'B'});
            testCase.verifyFalse(dg.hasVertex('A'));
            testCase.verifyTrue(dg.hasVertex('B'));
            
            dg.removeVertex('B');
            testCase.verifyEqual(dg.NumVertices,0);
            testCase.verifyEmpty(dg.Vertex);
            testCase.verifyFalse(dg.hasVertex('A'));
            testCase.verifyFalse(dg.hasVertex('B'));
            
        end
        
        %------------------------------------------------------------------
        function Edge(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            testCase.verifyEqual(dg.NumEdges,0);
            testCase.verifyFalse(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyFalse(dg.hasEdge('B','C'));
            
            dg.addEdge('A','B');
            testCase.verifyEqual(dg.NumEdges,1);
            testCase.verifyTrue(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyFalse(dg.hasEdge('B','C'));
            
            % add same edge again, should get same results without error
            dg.addEdge('A','B');
            testCase.verifyEqual(dg.NumEdges,1);
            testCase.verifyTrue(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyFalse(dg.hasEdge('B','C'));
            
            dg.addEdge('B','C');
            testCase.verifyEqual(dg.NumEdges,2);
            testCase.verifyTrue(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyTrue(dg.hasEdge('B','C'));
            
            dg.removeEdge('A','B');
            testCase.verifyEqual(dg.NumEdges,1);
            testCase.verifyFalse(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyTrue(dg.hasEdge('B','C'));
            
            dg.removeEdge('B','C');
            testCase.verifyEqual(dg.NumEdges,0);
            testCase.verifyFalse(dg.hasEdge('A','B'));
            testCase.verifyFalse(dg.hasEdge('A','C'));
            testCase.verifyFalse(dg.hasEdge('B','C'));
        end
        
        % -----------------------------------------------------------------
        function unionBasic(testCase)
            dg1 = digraph;
            dg2 = digraph;
            dg2.addVertex('foo')
            testCase.verifyTrue(isEquivalent(union(dg1,dg2),dg2))
            testCase.verifyTrue(isEquivalent(union(dg2,dg1),dg2))
        end
        
        %------------------------------------------------------------------
        function unionAdvanced(testCase)
            
            dg1 = digraph();
            dg1.addVertex('A');
            dg1.addVertex('B');
            dg1.addVertex('C');
            dg1.addVertex('D');
            
            dg2 = digraph();
            dg2.addVertex('C');
            dg2.addVertex('D');
            dg2.addVertex('E');
            dg2.addVertex('F');
            
            dg1.addEdge('A','B');
            dg1.addEdge('B','C');
            dg1.addEdge('A','D');
            
            dg2.addEdge('C','D');
            dg2.addEdge('E','D');
            dg2.addEdge('C','F');
            
            expVal = digraph();
            expVal.addVertex('A');
            expVal.addVertex('B');
            expVal.addVertex('C');
            expVal.addVertex('D');
            expVal.addVertex('E');
            expVal.addVertex('F');
            expVal.addEdge('A','B');
            expVal.addEdge('B','C');
            expVal.addEdge('A','D');
            expVal.addEdge('C','D');
            expVal.addEdge('E','D');
            expVal.addEdge('C','F');
            
            dgUnion = union(dg1,dg2);
            testCase.verifyTrue(dgUnion.isEquivalent(expVal));
            
        end
        
        % -----------------------------------------------------------------
        function intersectBasic(testCase)
            dg1 = digraph;
            dg2 = digraph;
            dg2.addVertex('foo')
            testCase.verifyTrue(isEquivalent(intersect(dg1,dg2),dg1))
            testCase.verifyTrue(isEquivalent(intersect(dg2,dg1),dg1))
        end
        
        %------------------------------------------------------------------
        function intersectAdvanced(testCase)
            
            dg1 = digraph();
            dg1.addVertex('A');
            dg1.addVertex('B');
            dg1.addVertex('C');
            dg1.addVertex('D');
            dg1.addVertex('E');
            
            dg2 = digraph();
            dg2.addVertex('C');
            dg2.addVertex('D');
            dg2.addVertex('E');
            dg2.addVertex('F');
            dg2.addVertex('G');
            
            dg1.addEdge('A','B');
            dg1.addEdge('B','C');
            dg1.addEdge('A','D');
            dg1.addEdge('C','D');
            dg1.addEdge('C','E');
            dg2.addEdge('C','D');
            dg2.addEdge('E','D');
            dg2.addEdge('C','F');
            
            expVal = digraph();
            expVal.addVertex('C');
            expVal.addVertex('D');
            expVal.addVertex('E');
            expVal.addEdge('C','D');
            
            dgUnion = intersect(dg1,dg2);
            testCase.verifyTrue(dgUnion.isEquivalent(expVal));
            
        end
        
        %------------------------------------------------------------------
        function hasPath(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            testCase.verifyFalse(dg.hasPath('A','C'));
            
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            testCase.verifyTrue(dg.hasPath('A','C'));
        end
        
        % -----------------------------------------------------------------
        function sort(testCase)
            
            dg = digraph;
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('A');
            dg.addEdge('C','A')
            testCase.verifyEqual(dg.Vertex,{'B','C','A'});
            s = sort(dg);
            testCase.verifyEqual(s.Vertex,{'A','B','C'});
            testCase.verifyTrue(isEquivalent(dg,s));
            
        end
        
        %------------------------------------------------------------------
        function shortestPathBasic(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            testCase.verifyEmpty(dg.shortestPath('A','E'));
            
            % A->B->E and A->C->D->E
            dg.addEdge('A','B');
            dg.addEdge('B','E');
            dg.addEdge('A','C');
            dg.addEdge('C','D');
            dg.addEdge('D','E');
            testCase.verifyEqual(dg.shortestPath('A','B'),{'A' 'B'});
            testCase.verifyEqual(dg.shortestPath('A','E'),{'A' 'B' 'E'});
            
            % break that shortest path to find the next
            dg.removeEdge('B','E');
            testCase.verifyEqual(...
                dg.shortestPath('A','E'),{'A' 'C' 'D' 'E'});
        end
        
        %------------------------------------------------------------------
        function shortestPathAdvanced(testCase)
            
            dg = digraph;
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B')
            dg.addEdge('B','A')
            dg.addEdge('C','C')
            
            testCase.verifyEqual(dg.shortestPath('A','B'),{'A' 'B'})
            testCase.verifyEqual(dg.shortestPath('A','A'),{'A'})
            testCase.verifyEqual(dg.shortestPath('A','C'),{})
            testCase.verifyEqual(dg.shortestPath('C','C'),{'C'})
            
        end
        
        %------------------------------------------------------------------
        function hasCycle(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            testCase.verifyFalse(dg.hasCycle);
            
            dg.addEdge('C','A');
            testCase.verifyTrue(dg.hasCycle);
            
        end
        
        %------------------------------------------------------------------
        function CycleDoesNotTriggerInfiniteLoop(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            dg.addEdge('C','A');
            
            tc = dg.transitiveClosure();
            me = dg.minimalEdges();
            testCase.verifyEqual(tc.NumEdges,9);
            testCase.verifyEqual(me.NumEdges,3);
            
            testCase.verifyEqual(dg.findall('A',Inf),{'A' 'B' 'C'});
            testCase.verifyEqual(dg.findall('A',-Inf),{'A' 'B' 'C'});
            
            testCase.verifyTrue(dg.hasCycle);
            testCase.verifyTrue(dg.hasPath('A','A'));
            testCase.verifyEqual(dg.shortestPath('A','A'),{'A'});
            testCase.verifyTrue(dg.hasPath('A','C'));
            testCase.verifyEqual(dg.shortestPath('A','C'),{'A' 'B' 'C'});
            
        end
        
        %------------------------------------------------------------------
        function findall(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            dg.addVertex('F');
            dg.addVertex('G');
            dg.addVertex('H');
            dg.addVertex('I');
            
            % A->B->I, C->D->I, and I->E->F, I->G->H
            dg.addEdge('A','B');
            dg.addEdge('B','I');
            dg.addEdge('C','D');
            dg.addEdge('D','I');
            dg.addEdge('I','E');
            dg.addEdge('E','F');
            dg.addEdge('I','G');
            dg.addEdge('G','H');
            
            % middle vertex
            testCase.verifyEqual(...
                dg.findall('I',NaN),{});
            testCase.verifyEqual(...
                dg.findall('I',0),{});
            testCase.verifyEqual(...
                dg.findall('I',1),{'E' 'G'});
            testCase.verifyEqual(...
                dg.findall('I',inf), {'E' 'F' 'G' 'H'});
            testCase.verifyEqual(...
                dg.findall('I',-1),{'B' 'D'});
            testCase.verifyEqual(...
                dg.findall('I',-inf),{'A' 'B' 'C' 'D'});
            
            % "top" vertex
            testCase.verifyEqual(...
                dg.findall('A',1),{'B'});
            testCase.verifyEqual(...
                dg.findall('A',2),{'B','I'});
            testCase.verifyEqual(...
                dg.findall('A',3),{'B','E','G','I'});
            testCase.verifyEqual(...
                dg.findall('A',4),{'B','E','F','G','H','I'});
            testCase.verifyEqual(...
                dg.findall('A',5),{'B','E','F','G','H','I'});
            testCase.verifyEqual(...
                dg.findall('A',Inf),{'B','E','F','G','H','I'});
            
            % "bottom" vertex
            testCase.verifyEqual(...
                dg.findall('H',-1),{'G'});
            testCase.verifyEqual(...
                dg.findall('H',-2),{'G','I'});
            testCase.verifyEqual(...
                dg.findall('H',-3),{'B','D','G','I'});
            testCase.verifyEqual(...
                dg.findall('H',-4),{'A','B','C','D','G','I'});
            testCase.verifyEqual(...
                dg.findall('H',-5),{'A','B','C','D','G','I'});
            testCase.verifyEqual(...
                dg.findall('H',-Inf),{'A','B','C','D','G','I'});
        end
        
        %------------------------------------------------------------------
        function subgraph(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            
            % A->B->{C,D}->E, A->C
            dg.addEdge('A','B');
            dg.addEdge('A','C');
            dg.addEdge('B','C');
            dg.addEdge('B','D');
            dg.addEdge('C','E');
            dg.addEdge('D','E');
            
            sg = dg.subgraph({'B','C','E'});
            testCase.verifyEqual(sg.NumVertices,3);
            testCase.verifyTrue(sg.hasVertex('B'));
            testCase.verifyTrue(sg.hasVertex('C'));
            testCase.verifyTrue(sg.hasVertex('E'));
            testCase.verifyEqual(sg.NumEdges,2);
            testCase.verifyTrue(sg.hasEdge('B','C'));
            testCase.verifyTrue(sg.hasEdge('C','E'));
            
            sg = dg.subgraph({});
            testCase.verifyTrue(isEquivalent(digraph,sg));
            justOne = digraph;
            justOne.addVertex('A');
            sg = dg.subgraph({'A'});
            testCase.verifyTrue(isEquivalent(justOne,sg));
            sg = dg.subgraph(dg.Vertex);
            testCase.verifyTrue(isEquivalent(dg,sg));
        end
        
        %------------------------------------------------------------------
        function isEquivalent(testCase)
            
            dg1 = digraph();
            dg1.addVertex('A');
            dg1.addVertex('B');
            dg1.addVertex('C');
            dg1.addEdge('A','B');
            dg1.addEdge('B','C');
            
            dg2 = digraph();
            dg2.addVertex('C');
            dg2.addVertex('A');
            % wrong number of vertices
            testCase.verifyFalse(dg1.isEquivalent(dg2));
            dg2.addVertex('D');
            % right number of vertices, wrong ones
            testCase.verifyFalse(dg1.isEquivalent(dg2));
            dg2.removeVertex('D'); % remove it
            dg2.addVertex('B');
            dg2.addEdge('A','B');
            % right number of vertices, wrong edges
            testCase.verifyFalse(dg1.isEquivalent(dg2));
            dg2.addEdge('B','C');
            testCase.verifyTrue(dg1.isEquivalent(dg2));
            dg2.addEdge('A','C');
            testCase.verifyFalse(dg1.isEquivalent(dg2));
        end
        
        %------------------------------------------------------------------
        function copy_(testCase)
            
            dg1 = digraph();
            dg1.addVertex('A');
            dg1.addVertex('B');
            dg1.addVertex('C');
            dg1.addEdge('A','B');
            dg1.addEdge('B','C');
            
            dg2 = dg1.copy();
            testCase.verifyTrue(dg1.isEquivalent(dg2));
            dg2.addEdge('A','C');
            testCase.verifyFalse(dg1.hasEdge('A','C'));
            dg2.addVertex('foo');
            testCase.verifyFalse(dg1.hasVertex('foo'));
        end
        
        % -----------------------------------------------------------------
        function isComplete(testCase)
            
            dg = digraph;
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('A','C');
            dg.addEdge('B','A');
            dg.addEdge('B','C');
            dg.addEdge('C','A');
            testCase.verifyFalse(dg.isComplete);
            dg.addEdge('C','B');
            testCase.verifyTrue(dg.isComplete);
            
            dg.addEdge('A','A');
            dg.addEdge('B','B');
            testCase.verifyTrue(dg.isComplete);
            dg.addEdge('C','C');
            testCase.verifyTrue(dg.isComplete);
        end
        
        % -----------------------------------------------------------------
        function isempty_(testCase)
            
            dg = digraph;
            testCase.verifyTrue(dg.isempty)
            dg.addVertex('foo')
            testCase.verifyFalse(dg.isempty)
            dg.removeVertex('foo')
            testCase.verifyTrue(dg.isempty)
        end
        
        %------------------------------------------------------------------
        function transitiveClosureBasic(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            tc = dg.transitiveClosure();
            
            testCase.verifyEqual(tc.NumEdges,3);
            testCase.verifyTrue(tc.hasEdge('A','C'));
        end
        
        %------------------------------------------------------------------
        function transitiveClosureAdvanced(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            dg.addVertex('F');
            dg.addVertex('G');
            
            % {A,B,C} -> {D} -> {E,F,G}
            dg.addEdge('A','D');
            dg.addEdge('B','D');
            dg.addEdge('C','D');
            dg.addEdge('D','E');
            dg.addEdge('D','F');
            dg.addEdge('D','G');
            tc = dg.transitiveClosure();
            
            testCase.verifyEqual(tc.NumEdges,15);
            testCase.verifyTrue(tc.hasEdge('A','E'));
            testCase.verifyTrue(tc.hasEdge('A','F'));
            testCase.verifyTrue(tc.hasEdge('A','G'));
            testCase.verifyTrue(tc.hasEdge('B','E'));
            testCase.verifyTrue(tc.hasEdge('B','F'));
            testCase.verifyTrue(tc.hasEdge('B','G'));
            testCase.verifyTrue(tc.hasEdge('C','E'));
            testCase.verifyTrue(tc.hasEdge('C','F'));
            testCase.verifyTrue(tc.hasEdge('C','G'));
        end
        
        % -----------------------------------------------------------------
        function transitiveClosureCycleAndComplete(testCase)
            
            dg = digraph;
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            dg.addEdge('C','A');
            fullGraph = copy(dg);
            fullGraph.addEdge('A','C');
            fullGraph.addEdge('B','A');
            fullGraph.addEdge('C','B');
            fullGraph.addEdge('A','A');
            fullGraph.addEdge('B','B');
            fullGraph.addEdge('C','C');
            testCase.verifyTrue(...
                isEquivalent(fullGraph,transitiveClosure(dg)));
            dg.addEdge('A','A');
            testCase.verifyTrue(...
                isEquivalent(fullGraph,transitiveClosure(dg)));
            dg.addEdge('B','B');
            dg.addEdge('C','C');
            testCase.verifyTrue(...
                isEquivalent(fullGraph,transitiveClosure(dg)));
            
        end
        
        %------------------------------------------------------------------
        function minimalEdgesBasic(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('B','C');
            dg.addEdge('A','C');
            me = dg.minimalEdges();
            
            testCase.verifyEqual(me.NumEdges,2);
            testCase.verifyFalse(me.hasEdge('A','C'));
        end
        
        %------------------------------------------------------------------
        function minimalEdgesAdvanced(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            dg.addVertex('F');
            dg.addVertex('G');
            
            % {A,B,C} -> {D,E,F,G} and {D} -> {E,F,G}
            dg.addEdge('A','D');
            dg.addEdge('A','E');
            dg.addEdge('A','F');
            dg.addEdge('A','G');
            dg.addEdge('B','D');
            dg.addEdge('B','E');
            dg.addEdge('B','F');
            dg.addEdge('B','G');
            dg.addEdge('C','D');
            dg.addEdge('C','E');
            dg.addEdge('C','F');
            dg.addEdge('C','G');
            dg.addEdge('D','E');
            dg.addEdge('D','F');
            dg.addEdge('D','G');
            me = dg.minimalEdges();
            
            testCase.verifyEqual(me.NumEdges,6);
            testCase.verifyFalse(me.hasEdge('A','E'));
            testCase.verifyFalse(me.hasEdge('A','F'));
            testCase.verifyFalse(me.hasEdge('A','G'));
            testCase.verifyFalse(me.hasEdge('B','E'));
            testCase.verifyFalse(me.hasEdge('B','F'));
            testCase.verifyFalse(me.hasEdge('B','G'));
            testCase.verifyFalse(me.hasEdge('C','E'));
            testCase.verifyFalse(me.hasEdge('C','F'));
            testCase.verifyFalse(me.hasEdge('C','G'));
        end
        
        % -----------------------------------------------------------------
        function minimalEdgesCycleAndComplete(testCase)
            
            dg = digraph;
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addEdge('A','B');
            dg.addEdge('A','C');
            dg.addEdge('B','A');
            dg.addEdge('B','C');
            dg.addEdge('C','A');
            dg.addEdge('C','B');
            testCase.verifyTrue(isEquivalent(dg,minimalEdges(dg)));
            cp = copy(dg);
            dg.addEdge('A','A');
            testCase.verifyTrue(isEquivalent(cp,minimalEdges(dg)));
            dg.addEdge('B','B');
            dg.addEdge('C','C');
            testCase.verifyTrue(isEquivalent(cp,minimalEdges(dg)));
            
        end
        
        %------------------------------------------------------------------
        function trivialgraph(testCase)
            
            dg = digraph();
            
            dg.addVertex('A');
            testCase.verifyEqual(dg.minimalEdges.NumEdges,0);
            testCase.verifyEqual(dg.transitiveClosure.NumEdges,0)
            testCase.verifyFalse(dg.hasCycle);
            testCase.verifyTrue(dg.hasPath('A','A'));
            testCase.verifyEqual(dg.shortestPath('A','A'),{'A'});
            
            dg.addEdge('A','A');
            testCase.verifyEqual(dg.minimalEdges.NumEdges,0);
            testCase.verifyEqual(dg.transitiveClosure.NumEdges,1);
            testCase.verifyTrue(dg.hasCycle);
            testCase.verifyTrue(dg.hasPath('A','A'));
            testCase.verifyEqual(dg.shortestPath('A','A'),{'A'});
        end
        
        %------------------------------------------------------------------
        function isEquivalentSubclass(testCase)
            
            sub = digraphSubclass();
            sub.addVertex('A');
            sub.addVertex('B');
            sub.addEdge('A','B');
            
            sup = digraph;
            sup.addVertex('A');
            sup.addVertex('B');
            sup.addEdge('A','B');
            
            cl = sub.copy();
            testCase.verifyTrue(sub.isEquivalent(cl));
            testCase.verifyTrue(sub.isEquivalent(sup));
            
        end
        
        %------------------------------------------------------------------
        function subclassesArePreserved(testCase)
            
            subclass = 'digraphSubclass';
            sub = eval([subclass ';']);
            sub.addVertex('A');
            sub.addVertex('B');
            sub.addEdge('A','B');
            
            testCase.verifyClass(sub,                    subclass);
            testCase.verifyClass(sub.copy,               subclass);
            testCase.verifyClass(sub.sort,               subclass);
            testCase.verifyClass(sub.subgraph({'A','B'}),subclass);
            testCase.verifyClass(sub.minimalEdges,       subclass);
            testCase.verifyClass(sub.transitiveClosure,  subclass);
            
        end
        
        %------------------------------------------------------------------
        function spy(testCase)
            
            dg = digraph();
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addVertex('C');
            dg.addVertex('D');
            dg.addVertex('E');
            dg.addVertex('F');
            dg.addVertex('G');
            
            % {A,B,C} -> {D,E,F,G} and {D} -> {E,F,G}
            dg.addEdge('A','D');
            dg.addEdge('A','E');
            dg.addEdge('A','F');
            dg.addEdge('A','G');
            dg.addEdge('B','D');
            dg.addEdge('B','E');
            dg.addEdge('B','F');
            dg.addEdge('B','G');
            dg.addEdge('C','D');
            dg.addEdge('C','E');
            dg.addEdge('C','F');
            dg.addEdge('C','G');
            dg.addEdge('D','E');
            dg.addEdge('D','F');
            dg.addEdge('D','G');
            
            f = figure;
            dg.spy;
            
            lineHandle = findall(gca,'Type','line');
            
            testCase.verifyEqual(length(get(lineHandle,'XData')),...
                dg.NumEdges);
            
            close(f)
            
        end
        
    end
    
end