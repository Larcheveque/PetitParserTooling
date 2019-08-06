Class {
	#name : #PPTRuleStructureBuilderVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'strategy'
	],
	#category : #'PetitParserTooling-Tests'
}

{ #category : #helpers }
PPTRuleStructureBuilderVisitorTest >> obtainInitializedVisitorOnRule: aRuleSourceCode [
	| ast |
	ast := self class compiler parse: aRuleSourceCode.
	^ PPTRuleStructureBuilderVisitor
		newWithStrategy: strategy
		onRule: ast
]

{ #category : #running }
PPTRuleStructureBuilderVisitorTest >> setUp [ 
	strategy := PPTASTGeneratorStrategy testStrategy.
	
]

{ #category : #running }
PPTRuleStructureBuilderVisitorTest >> testIgnore [
	| visitor |
	visitor := self obtainInitializedVisitorOnRule: 'myRule
	<ignore: #toIgnore>
	^ ruleA, (toIgnore / $r parser)'.
	self assertCollection: visitor ruleLocalIgnoring equals: {#toIgnore} asOrderedCollection 
]

{ #category : #running }
PPTRuleStructureBuilderVisitorTest >> testRename [
	| visitor |
	visitor := self
		obtainInitializedVisitorOnRule:
			'myRule
	<rename: #toRename into: #renamed>
	^ ruleA, (toIgnore / $r parser)'.
	self
		assertCollection: visitor ruleRenaming
		equals: {(#toRename -> {#renamed})} asDictionary
]
