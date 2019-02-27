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
	ast := self class compiler parse: aRuleSourceCode.
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
				, (structure methodCodeForProductionName: #production) , '; yourself ]'
		equals: aParserSourceCode
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> setUp [ 
	strategy := PPASTGeneratorStrategy testStrategy 
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testAtPositionPlusAtPosition [
	self
		rule:
			'sequence
	^ ''ignored'' parser, ''ignored'' parser, ruleA , (''ignored'' parser, ruleB) plus'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence ==> [ :production | ASTNodeSequence new ruleA: (production at: 3); ruleBs: ((production at: 4) collect: [:subProduction | subProduction at: 2]); yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testOperatorExpression [
	self
		rule:
			'operatorExpression
	^ methodInvocation optional , $+ parser, expression'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule ==> [ :production | ASTNodeMyRule new dependingRule: production; yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testPlus [
	self
		rule:
			'sequence
	^ ruleA plus'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence ==> [ :production | ASTNodeSequence new ruleAs: production; yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testPlusAtPosition [
	self
		rule:
			'sequence
	^ ruleA , ruleB plus'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence ==> [ :production | ASTNodeSequence new ruleA: (production at: 1); ruleBs: (production at: 2); yourself ]'
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
	^ super array ==> [ :production | ASTNodeArray new expressions: (self rejectSeparators: (production at: 2)); yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testSequenceOptional [
	self
		rule:
			'sequence
	^ ruleA, (ruleB, ruleC) optional'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence ==> [ :production | ASTNodeSequence new ruleA: (production at: 1); ruleB: ((production at: 2) ifNotEmpty: [((production at: 2) at: 1)]); ruleC: ((production at: 2) ifNotEmpty: [((production at: 2) at: 2)]); yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testSequencePosition [
	self
		rule:
			'arrayPosition
	^ $[ parser , expression, $] parser'
		shouldProduceParser:
			'arrayPosition
	<generated>
	^ super arrayPosition ==> [ :production | ASTNodeArrayPosition new expression: (production at: 2); yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testSimpleOption [
	self
		rule:
			'sequence
	^ rule optional'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence ==> [ :production | ASTNodeSequence new rule: production; yourself ]'
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
	^ super myRule ==> [ :production | ASTNodeMyRule new dependingRule: production; yourself ]'
]
