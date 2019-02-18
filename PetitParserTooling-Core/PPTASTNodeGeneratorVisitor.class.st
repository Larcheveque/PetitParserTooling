Class {
	#name : #PPTASTNodeGeneratorVisitor,
	#superclass : #PPTGeneratorVisitor,
	#category : #'PetitParserTooling-Core'
}

{ #category : #creation }
PPTASTNodeGeneratorVisitor >> createAstNodeClass: aRule [ 
	^ Object
		subclass: (self generationStrategy astNodeClassNameForRule: aRule)
		instanceVariableNames: ''
		classVariableNames: ''
		package: self generationStrategy astPackage.
]

{ #category : #generation }
PPTASTNodeGeneratorVisitor >> createAttributeAndAccessorsFor: anAttributeName inClass: class [
	class addInstVarNamed: anAttributeName.
	(RBCreateAccessorsForVariableRefactoring
		variable: anAttributeName
		class: class
		classVariable: false) execute
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2ActionNode: aPP2ActionNode [ 
	^ aPP2ActionNode child acceptVisitor: self
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2ChoiceNode: aPP2ChoiceNode [
	| key |
	"Should manage if only one rule is obtained from childen visit"
	key := aPP2ChoiceNode children
		collect: [ :aChild | aChild acceptVisitor: self ] thenSelect: #isString.
	^ self ruleReifications
		at: key
		ifAbsent: [ PPTChoiceReificationNotDefined new
				rulesCombination: key;
				signal ]
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2DelegateNode: aPP2DelegateNode [ 
	^ aPP2DelegateNode name
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2NotNode: aPP2NotNode [ 
	"a not is never interesting to be stored in the AST"
	^ nil
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2OptionalNode: aPP2OptionalNode [ 
	^ aPP2OptionalNode child acceptVisitor: self
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2PossesiveRepeatingNode: aPP2PossesiveRepeatingNode [ 
	^ (aPP2PossesiveRepeatingNode child acceptVisitor: self), 's' 
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2PredicateSequenceNode: aPP2PredicateSequenceNode [ 
	^ nil
]

{ #category : #visit }
PPTASTNodeGeneratorVisitor >> visitPP2SequenceNode: aPP2SequenceNode [
	^ aPP2SequenceNode children
		collect: [ :aChild | aChild acceptVisitor: self ]
		thenSelect: #isString
]

{ #category : #visiting }
PPTASTNodeGeneratorVisitor >> visitPPRule: aPP2DelegateNode [
	| result class |
	class := self createAstNodeClass: aPP2DelegateNode name.
	result := aPP2DelegateNode child acceptVisitor: self.
	result isString
		ifTrue: [ self createAttributeAndAccessorsFor: result inClass: class ]
		ifFalse: [ result
				do: [ :subRuleName | self createAttributeAndAccessorsFor: subRuleName inClass: class ] ]
]
