Class {
	#name : #PPTParserGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'strategy'
	],
	#category : #'PetitParserTooling-Tests'
}

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> rule: aRuleSourceCode shouldProduceParser: aParserSourceCode [
	| visitor ast parser structure ruleName |
	visitor := PPTParserTestVisitor new.
	ast := OpalCompiler new parse: aRuleSourceCode.
	ruleName := ast selector.
	ast body acceptVisitor: visitor.
	parser := PP2DelegateNode
		on: (self class evaluate: visitor codeStream contents).
	parser name: ast selector.
	structure := (PPTRuleStructureBuilderVisitor
		newWithStrategy: strategy
		onRule: ruleName) visitGrammarRule: parser.
	self
		assert:
			ruleName
				,
					'
	<generated>
	^ super ' , ruleName , ' ==> [ :production | '
				, (strategy astNodeClassNameForRule: ruleName) , ' new '
				, (structure methodCodeWith: #production) , ' ]'
		equals: aParserSourceCode
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> setUp [ 
	strategy := PPASTGeneratorStrategy testStrategy 
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testSeparatedByWithPosition [
	self
		rule:
			'array
	^ ${ parser , (expression separatedBy: $, parser) , $} parser'
		shouldProduceParser:
			'array
	<generated>
	^ super array ==> [ :production | ASTNodeArray new expressions: (self rejectSeparators: (production at: 2)) ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testSimpleRule [
	self
		rule:
			'myRule
	^ dependingRule'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule ==> [ :production | ASTNodeMyRule new dependingRule: production ]'
]
