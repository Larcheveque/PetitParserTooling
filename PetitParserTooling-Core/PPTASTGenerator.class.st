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

{ #category : #creation }
PPTASTGenerator class >> createASTNodeForRule: aRule ruleStructure: aRuleStructure generationStrategy: aGenerationStrategy [
	| astClass |
	astClass := aGenerationStrategy createAstNodeClass: aRule.
	aRuleStructure allAssignations
		do: [ :anAssignation | 
			aGenerationStrategy
				createAttributeAndAccessorsFor: anAssignation finalName
				inClass: astClass ].
	astClass
		compile:
			'acceptVisitor: aVisitor
	<generated>
	^ aVisitor visit' , astClass name , ': self'
		classified: #visiting.
	aGenerationStrategy createPositionsInClass: astClass.
	(RBGenerateEqualHashRefactoring
		className: astClass
		variables: astClass instVarNames) execute
]

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
		classVariable: false) execute.
	aPPASTGeneratorStrategy createPositionsInClass: astClass.
	(RBGenerateEqualHashRefactoring
		className: astClass
		variables: astClass instVarNames) execute
]

{ #category : #generation }
PPTASTGenerator class >> createFlattenRule: aRuleName inParser: parserClass followingGenerationStrategy: aPPASTGeneratorStrategy [
	(PCGMethodNode selector: aRuleName)
		bodyBlock: [ :body | 
			body
				<<
					((((#super asPCGNode receiveMessage: aRuleName)
						receiveMessage: #flatten)
						receiveMessage: #withPositions
						if: aPPASTGeneratorStrategy keepPositions)
						receiveMessage: #==>
						with:
							((PCGBlockNode arguments: {#production asPCGArgument})
								bodyBlock: [ :body1 | 
									body1
										<<
											(((aPPASTGeneratorStrategy astNodeClassNameForRule: aRuleName)
												asPCGGlobal receiveMessage: #new) asCascadeTarget
												receiveMessage: #startPosition:
													with: (#production asPCGArgument receiveMessage: #start)
													if: aPPASTGeneratorStrategy keepPositions;
												receiveMessage: #stopPosition:
													with: (#production asPCGArgument receiveMessage: #stop)
													if: aPPASTGeneratorStrategy keepPositions;
												receiveMessage: aRuleName asMutator
													with:
													(#production asPCGArgument
														receiveMessage: #content
														if: aPPASTGeneratorStrategy keepPositions);
												receiveMessage: #yourself) ])) returnIt ];
		protocol: #rules;
		installOn: parserClass
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

{ #category : #creation }
PPTASTGenerator class >> createRule: aRule inParser: parserClass ruleStructure: aRuleStructure generationStrategy: aGenerationStrategy [
	aRuleStructure obtainPCGNode installOn: parserClass
]

{ #category : #generation }
PPTASTGenerator class >> createVisitingMethodForRule: aRule ruleStructure: aPPTRule generationStrategy: aPPASTGeneratorStrategy [
	| astNodeClass |
	astNodeClass := aPPASTGeneratorStrategy
		astNodeClassNameForRule: aRule.
	(self class environment at: aPPASTGeneratorStrategy visitorClass)
		compile:
			'visit' , astNodeClass , ': a' , astNodeClass
				,
					'
	<generated>
	'
				,
					('
	'
						join:
							(aPPTRule allAssignations
								select: #shouldGenerationBeVisited
								thenCollect: [ :anAssignation | 
									'self visit'
										,
											(anAssignation isPluralized
												ifTrue: [ 'All:' ]
												ifFalse: [ ':' ]) , ' a' , astNodeClass , ' '
										, anAssignation finalName , '.' ]))
		classified: #visiting
]

{ #category : #parserGeneration }
PPTASTGenerator class >> ensureParserClassFrom: aPPASTGeneratorStrategy existWithSuperclass: aClass [
	| parserClass |
	parserClass := [ self class environment
		at: (aPPASTGeneratorStrategy obtainParserClassFrom: aClass) ]
		on: NotFound
		do: [ aClass
				subclass:  (aPPASTGeneratorStrategy obtainParserClassFrom: aClass)
				instanceVariableNames: ''
				classVariableNames: ''
				package: aPPASTGeneratorStrategy parserPackage ].
	parserClass
		compile:
			'rejectSeparators: anArray
	<generated>
	^ anArray withIndexSelect: [:anElement :anIndex | anIndex odd]'
		classified: #helpers.
	parserClass
		compile:
			'selectSeparators: anArray
	<generated>
	^ anArray withIndexSelect: [:anElement :anIndex | anIndex even]'
		classified: #helpers.
	^ parserClass 
]

{ #category : #parserGeneration }
PPTASTGenerator class >> ensureVisitorClassFrom: aPPASTGeneratorStrategy [
	| visitor |
	visitor := [ self class environment
		at: aPPASTGeneratorStrategy visitorClass ]
		on: NotFound
		do: [ Object
				subclass: aPPASTGeneratorStrategy visitorClass
				instanceVariableNames: ''
				classVariableNames: ''
				package: aPPASTGeneratorStrategy visitorPackage ].
	visitor
		compile:
			'visit: aChildNode
	^ aChildNode ifNotNil: [ aChildNode acceptVisitor: self ]'
		classified: #helpers.
	visitor
		compile:
			'visitAll: childrenNodes
	childrenNodes
		ifNotNil: [ childrenNodes do: [ :aChildNode | aChildNode acceptVisitor: self ] ]'
		classified: #helpers
]

{ #category : #generation }
PPTASTGenerator class >> generateEverythingFrom: aGrammarClass generationStrategy: aGenerationStrategy [
	| grammar parserClass |
	parserClass := self
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
						inParser: parserClass
						followingGenerationStrategy: aGenerationStrategy.
					self
						createFlattenVisitingMethod: aGrammarRule
						generationStrategy: aGenerationStrategy ]
				else: [ | ruleStructure |
					ruleStructure := self
						obtainRuleStructureFor: aGrammarRule
						generationStrategy: aGenerationStrategy
						grammar: grammar.
					self
						createASTNodeForRule: aGrammarRule
						ruleStructure: ruleStructure
						generationStrategy: aGenerationStrategy.
					self
						createRule: aGrammarRule
						inParser: parserClass
						ruleStructure: ruleStructure
						generationStrategy: aGenerationStrategy.
					self
						createVisitingMethodForRule: aGrammarRule
						ruleStructure: ruleStructure
						generationStrategy: aGenerationStrategy ] ]
]

{ #category : #construction }
PPTASTGenerator class >> obtainRuleStructureFor: aRuleName generationStrategy: aPPASTGeneratorStrategy grammar: aGrammarPPInstance [
	| aRule |
	aRule := aGrammarPPInstance class lookupSelector: aRuleName.
	^ PPTRuleStructureBuilderVisitor
		obtainStructureFromRule: aRule
		parser: (aGrammarPPInstance productionAt: aRuleName)
		withStrategy: aPPASTGeneratorStrategy
]
