Class {
	#name : #PPASTGeneratorStrategy,
	#superclass : #Object,
	#instVars : [
		'rulesToFlatten',
		'rulesToIgnore',
		'parserPackage',
		'parserClass',
		'visitorPackage',
		'visitorClass',
		'astPackage',
		'astPrefix'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'as yet unclassified' }
PPASTGeneratorStrategy class >> pwbDataWindowStrategy [
	^ self new
		rulesToFlatten: #(identifier basicType booleanValue number parametrizedType string constant defaultVariable exitStatement uncheckedIdentifier defaultEventType graphicComponentToken generatorToken formatType);
		rulesToIgnore: #(blank spaces reservedKeyword newlines);
		parserPackage: #'PowerBuilder-Parser-Core';
		parserClass: #PWBDataWindowParser;
		astPackage: #'PowerBuilder-Parser-AST';
		astPrefix: #PWBAST;
		visitorPackage: #'PowerBuilder-Parser-Visitor';
		visitorClass: #PWBASTAbstractVisitor;
		yourself
]

{ #category : #'as yet unclassified' }
PPASTGeneratorStrategy class >> pwbStrategy [
	^ self new
		rulesToFlatten:
			#(identifier basicType booleanValue number parametrizedType string constant defaultVariable exitStatement uncheckedIdentifier defaultEventType graphicComponentToken generatorToken formatType this);
		rulesToIgnore: #(blank spaces reservedKeyword newlines);
		parserPackage: #'PowerBuilder-Parser-Core';
		parserClass: #PWBDataWindowParser;
		astPackage: #'PowerBuilder-Parser-AST';
		astPrefix: #PWBAST;
		visitorPackage: #'PowerBuilder-Parser-Visitor';
		visitorClass: #PWBASTAbstractVisitor;
		yourself
]

{ #category : #'as yet unclassified' }
PPASTGeneratorStrategy class >> pwbUserObjectStrategy [
	^ self new
		rulesToFlatten: #(identifier basicType booleanValue number parametrizedType string constant defaultVariable exitStatement uncheckedIdentifier defaultEventType graphicComponentToken generatorToken formatType accessModifier sqlQuery endForward this);
		rulesToIgnore: #(blank spaces reservedKeyword newlines );
		parserPackage: #'PowerBuilder-Parser-Core';
		parserClass: #PWBUserObjectParser;
		astPackage: #'PowerBuilder-Parser-AST';
		astPrefix: #PWBAST;
		visitorPackage: #'PowerBuilder-Parser-Visitor';
		visitorClass: #PWBASTAbstractVisitor;
		yourself
]

{ #category : #'as yet unclassified' }
PPASTGeneratorStrategy class >> testStrategy [
	^ self new
		rulesToFlatten: OrderedCollection new;
		rulesToIgnore: OrderedCollection new;
		astPrefix: #ASTNode;
		yourself
]

{ #category : #accessing }
PPASTGeneratorStrategy >> astNodeClassNameForRule: aRule [
	^ self astPrefix , aRule capitalized
]

{ #category : #accessing }
PPASTGeneratorStrategy >> astPackage [
	^ astPackage
]

{ #category : #accessing }
PPASTGeneratorStrategy >> astPackage: anObject [
	astPackage := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> astPrefix [
	^ astPrefix
]

{ #category : #accessing }
PPASTGeneratorStrategy >> astPrefix: anObject [
	astPrefix := anObject
]

{ #category : #creation }
PPASTGeneratorStrategy >> createAstNodeClass: aRule [
	^ Object
		subclass: (self astNodeClassNameForRule: aRule)
		instanceVariableNames: ''
		classVariableNames: ''
		package: self astPackage
]

{ #category : #generation }
PPASTGeneratorStrategy >> createAttributeAndAccessorsFor: anAttributeName inClass: class [
	(RBAddInstanceVariableRefactoring
		variable: anAttributeName
		class: class) execute.
	(RBCreateAccessorsForVariableRefactoring
		variable: anAttributeName
		class: class
		classVariable: false) execute
]

{ #category : #generation }
PPASTGeneratorStrategy >> createPositionsInClass: aClass [
	self createAttributeAndAccessorsFor: #startPosition inClass: aClass.
	self createAttributeAndAccessorsFor: #stopPosition inClass: aClass
]

{ #category : #dispatch }
PPASTGeneratorStrategy >> if: aRuleName shouldBeFlatten: aFlattenBlock else: aDefaultBlock [
	(self rulesToFlatten includes: aRuleName)
		ifTrue: [ aFlattenBlock value ]
		ifFalse: [ (self rulesToIgnore includes: aRuleName)
				ifFalse: [ aDefaultBlock value ] ]
]

{ #category : #dispatch }
PPASTGeneratorStrategy >> if: aRuleName shouldBeIgnored: ignoreBlock else: aDefaultBlock [
	^ (self rulesToIgnore includes: aRuleName)
		ifTrue: [ ignoreBlock value ]
		ifFalse: [ aDefaultBlock value ]
]

{ #category : #accessing }
PPASTGeneratorStrategy >> parserClass [
	^ parserClass
]

{ #category : #accessing }
PPASTGeneratorStrategy >> parserClass: anObject [
	parserClass := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> parserPackage [
	^ parserPackage
]

{ #category : #accessing }
PPASTGeneratorStrategy >> parserPackage: anObject [
	parserPackage := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> rulesToFlatten [
	^ rulesToFlatten
]

{ #category : #accessing }
PPASTGeneratorStrategy >> rulesToFlatten: anObject [
	rulesToFlatten := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> rulesToIgnore [
	^ rulesToIgnore
]

{ #category : #accessing }
PPASTGeneratorStrategy >> rulesToIgnore: anObject [
	rulesToIgnore := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> visitorClass [
	^ visitorClass
]

{ #category : #accessing }
PPASTGeneratorStrategy >> visitorClass: anObject [
	visitorClass := anObject
]

{ #category : #accessing }
PPASTGeneratorStrategy >> visitorPackage [
	^ visitorPackage
]

{ #category : #accessing }
PPASTGeneratorStrategy >> visitorPackage: anObject [
	visitorPackage := anObject
]
