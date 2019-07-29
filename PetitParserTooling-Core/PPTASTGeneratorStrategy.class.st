Class {
	#name : #PPTASTGeneratorStrategy,
	#superclass : #Object,
	#instVars : [
		'rulesToFlatten',
		'rulesToIgnore',
		'parserPackage',
		'parserClass',
		'visitorPackage',
		'visitorClass',
		'astPackage',
		'astPrefix',
		'keepPositions'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'as yet unclassified' }
PPTASTGeneratorStrategy class >> pwbStrategy [
	^ self new
		rulesToFlatten:
			#(identifier basicType booleanValue number parametrizedType string constant defaultVariable exitStatement uncheckedIdentifier defaultEventType graphicComponentToken generatorToken formatType this arrayDesignation argumentOption continueStatement);
		rulesToIgnore: #(blank spaces reservedKeyword newlines);
		parserPackage: #'PowerBuilder-Parser-Core';
		parserClass: #PWBDataWindowParser;
		astPackage: #'PowerBuilder-Parser-AST';
		astPrefix: #PWBAST;
		visitorPackage: #'PowerBuilder-Parser-Visitor';
		visitorClass: #PWBASTAbstractVisitor;
		keepPositions: true;
		yourself
]

{ #category : #'as yet unclassified' }
PPTASTGeneratorStrategy class >> pwbUserObjectStrategy [
	^ self new
		rulesToFlatten:
			#(identifier basicType booleanValue number parametrizedType string constant defaultVariable exitStatement uncheckedIdentifier defaultEventType graphicComponentToken generatorToken formatType accessModifier sqlQuery endForward this arrayDesignation argumentOption continueStatement);
		rulesToIgnore: #(blank spaces reservedKeyword newlines);
		parserPackage: #'PowerBuilder-Parser-Core';
		astPackage: #'PowerBuilder-Parser-AST';
		astPrefix: #PWBAST;
		parserClass:
				[ :originClass | originClass name copyReplaceAll: 'Grammar' with: 'Parser' ];
		visitorPackage: #'PowerBuilder-Parser-Visitor';
		visitorClass: #PWBASTAbstractVisitor;
		keepPositions: true;
		yourself
]

{ #category : #'as yet unclassified' }
PPTASTGeneratorStrategy class >> testStrategy [
	^ self new
		rulesToFlatten: OrderedCollection new;
		rulesToIgnore: OrderedCollection new;
		astPrefix: #ASTNode;
		yourself
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> astNodeClassNameForRule: aRule [
	^ self astPrefix , aRule capitalized
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> astPackage [
	^ astPackage
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> astPackage: anObject [
	astPackage := anObject
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> astPrefix [
	^ astPrefix
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> astPrefix: anObject [
	astPrefix := anObject
]

{ #category : #creation }
PPTASTGeneratorStrategy >> createAstNodeClass: aRule [
	^ Object
		subclass: (self astNodeClassNameForRule: aRule)
		instanceVariableNames: ''
		classVariableNames: ''
		package: self astPackage
]

{ #category : #generation }
PPTASTGeneratorStrategy >> createAttributeAndAccessorsFor: anAttributeName inClass: class [
	(RBAddInstanceVariableRefactoring
		variable: anAttributeName
		class: class) execute.
	(RBCreateAccessorsForVariableRefactoring
		variable: anAttributeName
		class: class
		classVariable: false) execute
]

{ #category : #generation }
PPTASTGeneratorStrategy >> createPositionsInClass: aClass [
	self keepPositions
		ifTrue: [ self createAttributeAndAccessorsFor: #startPosition inClass: aClass.
			self createAttributeAndAccessorsFor: #stopPosition inClass: aClass ]
]

{ #category : #dispatch }
PPTASTGeneratorStrategy >> if: aRuleName shouldBeFlatten: aFlattenBlock else: aDefaultBlock [
	(self rulesToFlatten includes: aRuleName)
		ifTrue: [ aFlattenBlock value ]
		ifFalse: [ (self rulesToIgnore includes: aRuleName)
				ifFalse: [ aDefaultBlock value ] ]
]

{ #category : #dispatch }
PPTASTGeneratorStrategy >> if: aRuleName shouldBeIgnored: ignoreBlock else: aDefaultBlock [
	^ (self rulesToIgnore includes: aRuleName)
		ifTrue: [ ignoreBlock value ]
		ifFalse: [ aDefaultBlock value ]
]

{ #category : #initialization }
PPTASTGeneratorStrategy >> initialize [ 
	super initialize.
	self keepPositions: false.
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> keepPositions [
	^ keepPositions
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> keepPositions: anObject [
	keepPositions := anObject
]

{ #category : #options }
PPTASTGeneratorStrategy >> nodeInstanceCreationOptions [
	^ self keepPositions ifTrue: [ 'startPosition: production start; stopPosition: production stop; ' ] ifFalse: [ '' ]
]

{ #category : #className }
PPTASTGeneratorStrategy >> obtainParserClassFrom: aClass [
	^ self parserClass isClosure
		ifTrue: [ self parserClass value: aClass ]
		ifFalse: [ self parserClass ]
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> parserClass [
	^ parserClass
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> parserClass: anObject [
	parserClass := anObject
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> parserPackage [
	^ parserPackage
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> parserPackage: anObject [
	parserPackage := anObject
]

{ #category : #options }
PPTASTGeneratorStrategy >> productionAccess [
	^ self keepPositions
		ifTrue: [ 'production content' ]
		ifFalse: [ #production ]
]

{ #category : #options }
PPTASTGeneratorStrategy >> rulesDecoration [
	^ self keepPositions
		ifTrue: [ 'withPositions ' ]
		ifFalse: [ '' ]
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> rulesToFlatten [
	^ rulesToFlatten
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> rulesToFlatten: anObject [
	rulesToFlatten := anObject
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> rulesToIgnore [
	^ rulesToIgnore
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> rulesToIgnore: anObject [
	rulesToIgnore := anObject
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> visitorClass [
	^ visitorClass
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> visitorClass: anObject [
	visitorClass := anObject
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> visitorPackage [
	^ visitorPackage
]

{ #category : #accessing }
PPTASTGeneratorStrategy >> visitorPackage: anObject [
	visitorPackage := anObject
]
