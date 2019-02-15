"
I am a generator that create an AST from a PetitParser grammar (a subclass of PPCompositeNode or PP2CompositeNode).

I base my generation on the rules and use pragma available in grammar rules: 
	<astAttributeRename: #identifier into: #functionName>
"
Class {
	#name : #PPTASTGenerator,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #generation }
PPTASTGenerator class >> createFlattenNodeForRule: aRule generationStrategy: aPPASTGeneratorStrategy [
	| astClass |
	astClass := Object
		subclass: (aPPASTGeneratorStrategy astNodeClassNameForRule: aRule)
		instanceVariableNames: aRule
		classVariableNames: ''
		package: aPPASTGeneratorStrategy astPackage.
	astClass
		compile:
			'acceptVisitor: aVisitor
	<generated>
	^ aVisitor visit' , astClass name , ': self'
		classified: #visiting.
	(RBCreateAccessorsForVariableRefactoring
		variable: aRule
		class: astClass
		classVariable: false) execute
]

{ #category : #generation }
PPTASTGenerator class >> createFlattenRule: aRuleName inParserFollowingGenerationStrategy: aPPASTGeneratorStrategy [
	(self class environment at: aPPASTGeneratorStrategy parserClass)
		compile:
			aRuleName
				,
					'
	<generated>
	^ super ' , aRuleName , ' flatten ==> [ :production | '
				, (aPPASTGeneratorStrategy astNodeClassNameForRule: aRuleName)
				, ' new ' , aRuleName , ': production; yourself ]'
		classified: 'rules'
]

{ #category : #generation }
PPTASTGenerator class >> createFlattenVisitingMethod: aRule generationStrategy: aPPASTGeneratorStrategy [
	| astNodeClass |
	astNodeClass := aPPASTGeneratorStrategy
		astNodeClassNameForRule: aRule.
	(self class environment at: aPPASTGeneratorStrategy visitorClass)
		compile:
			'visit' , astNodeClass , ': an' , astNodeClass
				,
					'
	<generated>
	^ an' , astNodeClass , ' ' , aRule
		classified: #visiting
]

{ #category : #generation }
PPTASTGenerator class >> createNodeForRule: aRule generationStrategy: aPPASTGeneratorStrategy grammar: aGrammarPPInstance [
	(PPTASTNodeGeneratorVisitor newWithStrategy: aPPASTGeneratorStrategy onRule: (aGrammarPPInstance class lookupSelector:  aRule))
		visitPPRule: (aGrammarPPInstance productionAt: aRule)
]

{ #category : #generation }
PPTASTGenerator class >> createRule: aRule inParserFollowingGenerationStrategy: aPPASTGeneratorStrategy grammar: aGrammarPPInstance [
	(PPTParserGeneratorVisitor
		newWithStrategy: aPPASTGeneratorStrategy
		onRule: (aGrammarPPInstance class lookupSelector: aRule))
		visitPPRule: (aGrammarPPInstance productionAt: aRule)
]

{ #category : #parserGeneration }
PPTASTGenerator class >> ensureParserClassFrom: aPPASTGeneratorStrategy existWithSuperclass: aClass [
	[ self class environment at: aPPASTGeneratorStrategy parserClass ]
		on: NotFound
		do: [ aClass
				subclass: aPPASTGeneratorStrategy parserClass
				instanceVariableNames: ''
				classVariableNames: ''
				package: aPPASTGeneratorStrategy parserPackage ]
]

{ #category : #parserGeneration }
PPTASTGenerator class >> ensureVisitorClassFrom: aPPASTGeneratorStrategy [
	[ self class environment at: aPPASTGeneratorStrategy visitorClass ]
		on: NotFound
		do: [ Object
				subclass: aPPASTGeneratorStrategy visitorClass
				instanceVariableNames: ''
				classVariableNames: ''
				package: aPPASTGeneratorStrategy visitorPackage ]
]

{ #category : #'as yet unclassified' }
PPTASTGenerator class >> generateEverythingFrom: aGrammarClass generationStrategy: aGenerationStrategy [
	| grammar |
	self
		ensureParserClassFrom: aGenerationStrategy
		existWithSuperclass: aGrammarClass.
	self ensureVisitorClassFrom: aGenerationStrategy.
	grammar := aGrammarClass new.
	grammar productionNames
		do: [ :aGrammarRule | 
			aGenerationStrategy
				if: aGrammarRule
				shouldBeFlatten: [ self
						createFlattenNodeForRule: aGrammarRule
						generationStrategy: aGenerationStrategy.
					self
						createFlattenRule: aGrammarRule
						inParserFollowingGenerationStrategy: aGenerationStrategy.
					self
						createFlattenVisitingMethod: aGrammarRule
						generationStrategy: aGenerationStrategy ]
				else: [ self
						createNodeForRule: aGrammarRule
						generationStrategy: aGenerationStrategy
						grammar: grammar.
					self
						createRule: aGrammarRule
						inParserFollowingGenerationStrategy: aGenerationStrategy
						grammar: grammar.
					"self
						createVisitingMethod: aGrammarRule
						generationStrategy: aGenerationStrategy
						grammar: grammar" ] ]
]

{ #category : #'as yet unclassified' }
PPTASTGenerator class >> obtainChildrenForRule: aGrammarRule inClass: aGrammarClass generationStrategy: aGenerationStrategy [
	aGrammarClass new productionAt: aGrammarRule.
	1 halt
]
