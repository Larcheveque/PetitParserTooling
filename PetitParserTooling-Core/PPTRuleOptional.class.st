Class {
	#name : #PPTRuleOptional,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #generation }
PPTRuleOptional >> methodCode [
	^ self rule isLeaf ifTrue: [ self rule methodCode ] ifFalse: [ Halt now. "should manage with ifNotNil: the optional branch" ]
]

{ #category : #generation }
PPTRuleOptional >> methodCodeWith: productionIdentifier [
	^ self rule isLeaf
		ifTrue: [ self rule methodCodeWith: productionIdentifier ]
		ifFalse: [ Halt now	"should manage with ifNotNil: the optional branch" ]
]

{ #category : #accessing }
PPTRuleOptional >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleOptional >> rule: anObject [
	rule := anObject
]
