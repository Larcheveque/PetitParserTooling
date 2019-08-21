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
	ast := self class compiler parse: aRuleSourceCode.
	visitor := PPTParserTestVisitor new.
	ruleName := ast selector.
	ast body acceptVisitor: visitor.
	parser := PP2DelegateNode
		on: (self class evaluate: visitor codeStream contents).
	parser name: ast selector.
	structure := PPTRuleStructureBuilderVisitor
		obtainStructureFromRule: ast
		parser: parser
		withStrategy: strategy.
	self assert: structure generatedSourceCode equals: aParserSourceCode
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> setUp [ 
	strategy := PPTASTGeneratorStrategy testStrategy.
	
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testAcknowledgePresence [
	self
		rule:
			'myRule
	<acknowledgePresence: #aToken>
	^ ruleA, ''aToken'' parser optional'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule
		==> [ :production | 
			ASTNodeMyRule new
				ruleA: (production at: 1);
				aToken: (production at: 2) notNil;
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testAcknowledgePresenceCaseInsensitiveInTrim [
	self
		rule:
			'executeProcedure
	<rename: #identifier into: #procedureName>
	<acknowledgePresence: #immediate>
	^ ''execute'' token , ''immediate'' parser caseInsensitive trim optional,  identifier trim'
		shouldProduceParser:
			'executeProcedure
	<generated>
	^ super executeProcedure
		==> [ :production | 
			ASTNodeExecuteProcedure new
				immediate: (production at: 2) notNil;
				procedureName: (production at: 3);
				yourself ]'
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
	^ super sequence
		==> [ :production | 
			ASTNodeSequence new
				ruleA: (production at: 3);
				ruleBs: ((production at: 4) collect: [ :subProduction | subProduction at: 2 ]);
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testIgnore [
	self
		rule:
			'myRule
	<ignore: #toIgnore>
	^ ruleA, (toIgnore / $r parser)'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule
		==> [ :production | 
			ASTNodeMyRule new
				ruleA: (production at: 1);
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testInvalidAcknowledgePresence [
	self
		should: [ self
				rule:
					'myRule
			<acknowledgePresence: #aToken>
	^ ruleA, (ruleB, ''aToken'' parser optional) plus'
				shouldProduceParser: '' ]
		raise: PPTInvalidAcknowledgeUsage
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testKeepPositionPlus [
	strategy keepPositions: true.
	self
		rule:
			'sequence
	^ ruleA plus'
		shouldProduceParser:
			'sequence
	<generated>
	^ super sequence withPositions
		==> [ :production | 
			ASTNodeSequence new
				startPosition: production start;
				stopPosition: production stop;
				ruleAs: production content;
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testNoAcknowledgePresence [
	self
		rule:
			'myRule
	^ ruleA, ''aToken'' parser optional'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule
		==> [ :production | 
			ASTNodeMyRule new
				ruleA: (production at: 1);
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testOperatorExpression [
	self
		rule:
			'myRule
	^ methodInvocation optional , $+ parser, expression'
		shouldProduceParser:
			'myRule
	<generated>
	^ super myRule
		==> [ :production | 
			ASTNodeMyRule new
				methodInvocation: (production at: 1);
				expression: (production at: 3);
				yourself ]'
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
	^ super sequence
		==> [ :production | 
			ASTNodeSequence new
				ruleAs: production;
				yourself ]'
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
	^ super sequence
		==> [ :production | 
			ASTNodeSequence new
				ruleA: (production at: 1);
				ruleBs: (production at: 2);
				yourself ]'
]

{ #category : #'as yet unclassified' }
PPTParserGenerationTest >> testReifyAllInto [
	self
		rule:
			'bigChoice
	<reifyAllInto: #choice>
	^ a / b / c / d / e / f / (g, h)'
		shouldProduceParser:
			'bigChoice
	<generated>
	^ super bigChoice
		==> [ :production | 
			ASTNodeBigChoice new
				choice: production;
				yourself ]'
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
	^ super array
		==> [ :production | 
			ASTNodeArray new
				expressions: (self rejectSeparators: (production at: 2));
				yourself ]'
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
	^ super sequence
		==> [ :production | 
			ASTNodeSequence new
				ruleA: (production at: 1);
				ruleB: ((production at: 2) ifNotNil: [ (production at: 2) at: 1 ]);
				ruleC: ((production at: 2) ifNotNil: [ (production at: 2) at: 2 ]);
				yourself ]'
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
	^ super arrayPosition
		==> [ :production | 
			ASTNodeArrayPosition new
				expression: (production at: 2);
				yourself ]'
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
	^ super sequence
		==> [ :production | 
			ASTNodeSequence new
				rule: production;
				yourself ]'
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
	^ super myRule
		==> [ :production | 
			ASTNodeMyRule new
				dependingRule: production;
				yourself ]'
]
