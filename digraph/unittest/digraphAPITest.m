classdef digraphAPITest < matlab.unittest.TestCase
%DIGRAPHAPITEST Unit-test for DIGRAPH API.
%
% Run by executing
%   run(DIGRAPHAPITEST)

% Copyright 2014 The MathWorks, Inc.
    
    methods(Test)
        
        %% Constructor and core methods
        
        function digraph(testCase)
            testCase.verifyError(@()digraph('foo'),'MATLAB:maxrhs');
            dg = digraph;
            testCase.verifyEqual(dg.AdjMat,sparse([],[],[],0,0,false));
            testCase.verifyEqual(dg.Vertex,{});
            testCase.verifyEqual(dg.NumVertices,0);
            testCase.verifyEqual(dg.NumEdges,0);
        end
        
        function isempty_(~)
            dg = digraph;
            dg.isempty;
        end
        
        function isEquivalent(testCase)
            dg1 = digraph;
            dg2 = digraph;
            isEquivalent(dg1,dg2);
            testCase.verifyError(@()isEquivalent(5,dg1),...
                'MATLAB:digraph:badinputclass');
            testCase.verifyError(@()isEquivalent(dg1,5),...
                'MATLAB:digraph:badinputclass');
            
        end
        
        %% Vertex methods
        
        function addVertex(testCase)
            dg = digraph;
            dg.addVertex('foo');
            testCase.verifyError(@()dg.addVertex(5),...
                'MATLAB:digraph:invalidvertexlabel')
        end
        
        function removeVertex(testCase)
            dg = digraph;
            dg.addVertex('foo');
            dg.removeVertex('foo');
            testCase.verifyError(@()dg.removeVertex('foo'),...
                'MATLAB:digraph:nosuchvertex');
            testCase.verifyError(@()dg.removeVertex(5),...
                'MATLAB:digraph:invalidvertexlabel');
        end
        
        function hasVertex(testCase)
            dg = digraph;
            dg.addVertex('foo');
            dg.hasVertex('foo');
            dg.hasVertex('bar');
            testCase.verifyError(@()dg.hasVertex(5),...
                'MATLAB:digraph:invalidvertexlabel');
        end
        
        function assertVertex(testCase)
            dg = digraph;
            dg.addVertex('foo');
            dg.assertVertex('foo');
            testCase.verifyError(@()dg.assertVertex('bar'),...
                'MATLAB:digraph:nosuchvertex');
            testCase.verifyError(@()dg.assertVertex(5),...
                'MATLAB:digraph:invalidvertexlabel');
        end
        
        %% Edge methods
        
        function addEdge(testCase)
            dg = digraph;
            dg.addVertex('foo'); dg.addVertex('bar');
            dg.addEdge('foo','bar')
            testCase.verifyError(@()dg.addEdge('foo','other'),...
                'MATLAB:digraph:nosuchvertex');
        end
        
        function removeEdge(testCase)
            dg = digraph;
            dg.addVertex('foo'); dg.addVertex('bar');
            dg.addEdge('foo','bar')
            dg.removeEdge('foo','bar')
            testCase.verifyError(@()dg.removeEdge('foo','other'),...
                'MATLAB:digraph:nosuchvertex');
        end
        
        function hasEdge(testCase)
            dg = digraph;
            dg.addVertex('foo'); dg.addVertex('bar');
            dg.hasEdge('foo','bar');
            testCase.verifyError(@()dg.hasEdge('foo','other'),...
                'MATLAB:digraph:nosuchvertex');
        end
        
        
        %% Search methods
        
        function findall(testCase)
            dg = digraph;
            dg.addVertex('foo');
            dg.findall('foo',-inf);
            dg.findall('foo',-5);
            dg.findall('foo',-1);
            dg.findall('foo',0);
            dg.findall('foo',nan);
            dg.findall('foo',1);
            dg.findall('foo',5);
            dg.findall('foo',inf);
            testCase.verifyError(@()dg.findall('bar',1),...
                'MATLAB:digraph:nosuchvertex');
            testCase.verifyError(@()dg.findall('foo',magic(4)),...
                'MATLAB:digraph:badinputtype');
        end
        
        function hasCycle(~)
            dg = digraph;
            dg.hasCycle;
        end
        
        function isComplete(~)
            dg = digraph;
            dg.isComplete;
        end
        
        function shortestPath(testCase)
            dg = digraph;
            dg.addVertex('foo'); dg.addVertex('bar');
            dg.shortestPath('foo','bar');
            testCase.verifyError(@()dg.shortestPath('foo','other'),...
                'MATLAB:digraph:nosuchvertex');
            testCase.verifyError(@()dg.shortestPath('other','bar'),...
                'MATLAB:digraph:nosuchvertex');
        end
        
        %% Subgraph methods
        
        function subgraph(testCase)
            dg = digraph;
            dg.addVertex('foo');
            dg.subgraph({'foo'});
            testCase.verifyError(@()dg.subgraph({'bar'}),...
                'MATLAB:digraph:nosuchvertex');
            testCase.verifyError(@()dg.subgraph('bar'),...
                'MATLAB:digraph:badinputtype');
            testCase.verifyError(@()dg.subgraph({2}),...
                'MATLAB:digraph:invalidvertexlabel');
        end
        
        %% Manipulation methods
        
        function minimalEdges(~)
            dg = digraph;
            dg.addVertex('foo');
            dg.minimalEdges;
        end
        
        function transitiveClosure(~)
            dg = digraph;
            dg.addVertex('foo');
            dg.transitiveClosure;
        end
        
        function union(testCase)
            dg1 = digraph;
            dg2 = digraph;
            union(dg1,dg2);
            testCase.verifyError(@()union(dg1,5),...
                'MATLAB:digraph:badinputclass');
            testCase.verifyError(@()union(5,dg1),...
                'MATLAB:digraph:badinputclass');
        end
        
        function intersect(testCase)
            dg1 = digraph;
            dg2 = digraph;
            intersect(dg1,dg2);
            testCase.verifyError(@()intersect(dg1,5),...
                'MATLAB:digraph:badinputclass');
            testCase.verifyError(@()intersect(5,dg1),...
                'MATLAB:digraph:badinputclass');
        end
        
        function sort(~)
            dg = digraph;
            dg.sort;
            dg.addVertex('foo');
            dg.sort;
        end
        
        function copy_(~)
            dg = digraph;
            dg.copy;
        end
        
        function reset(~)
            dg = digraph;
            dg.reset;
        end
        
        %% Display methods
        
        function spy(~)
            dg = digraph;
            dg.addVertex('A');
            dg.addVertex('B');
            dg.addEdge('A','B')
            
            f = figure;
            
            dg.spy
            dg.spy('-o')
            
            close(f)
        end
        
    end
    
end