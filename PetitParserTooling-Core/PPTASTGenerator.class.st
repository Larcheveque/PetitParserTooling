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
		subclass: aPPASTGeneratorStrategy astPrefix , aRule capitalized
		instanceVariableNames: aRule
		classVariableNames: ''
		package: aPPASTGeneratorStrategy astPackage.
	astClass
		compile:
			'acceptVisitor: aVisitor
	^ aVisitor visit' , astClass name , ': self'
		classified: #visiting.
	(RBCreateAccessorsForVariableRefactoring
		variable: aRule
		class: astClass
		classVariable: false) execute
]

{ #category : #'as yet unclassified' }
PPTASTGenerator class >> generateEverythingFrom: aGrammarClass generationStrategy: aGenerationStrategy [
	aGrammarClass basicNew productionNames
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
				else: [ | childrenRules |
					childrenRules := self
						obtainChildrenForRule: aGrammarRule
						inClass: aGrammarClass
						generationStrategy: aGenerationStrategy.
					self
						createNodeForRule: aGrammarRule
						generationStrategy: aGenerationStrategy
						childrenRules: childrenRules.
					self
						createRule: aGrammarRule
						inParserFollowingGenerationStrategy: aGenerationStrategy
						childrenRules: childrenRules.
					self
						createVisitingMethod: aGrammarRule
						generationStrategy: aGenerationStrategy
						childrenRules: childrenRules ] ]
]

{ #category : #'as yet unclassified' }
PPTASTGenerator class >> obtainChildrenForRule: aGrammarRule inClass: aGrammarClass generationStrategy: aGenerationStrategy [
	PP2SmalltalkParser
		parse: (aGrammarClass lookupSelector: aGrammarRule) sourceCode
]
