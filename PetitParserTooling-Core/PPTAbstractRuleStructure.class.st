"
PPTRules are a tree structure created from the visit of the Parser tree (PetitParser) and that reflect the logic of parser creation.

I am an intermediary structure so maybe i should be removed in the future if we are able to directly generate from the visit
"
Class {
	#name : #PPTAbstractRuleStructure,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #testing }
PPTAbstractRuleStructure >> ensureInteresting [
	self isNotInteresting
		ifTrue: [ PPTEmptyASTNode new signal ].
	^ self
]

{ #category : #testing }
PPTAbstractRuleStructure >> isInteresting [
	^ self isNotInteresting not
]

{ #category : #testing }
PPTAbstractRuleStructure >> isLeaf [
	^ false
]

{ #category : #testing }
PPTAbstractRuleStructure >> isNotInteresting [
	^ false
]

{ #category : #testing }
PPTAbstractRuleStructure >> isToken [
	^ false
]

{ #category : #serialization }
PPTAbstractRuleStructure >> obtainCodeRepresentation: aPPTCode [
	^ self subclassResponsibility 
]
