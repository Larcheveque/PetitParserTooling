Class {
	#name : #PPTRuleSeparatedBy,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule',
		'separator'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #serialization }
PPTRuleSeparatedBy >> obtainCodeRepresentation: aPPTCode [
	self flag: #TODO.	"Manage separator"
	^ (self rule obtainCodeRepresentation: aPPTCode) rejectSeparator
		pluralized
]

{ #category : #accessing }
PPTRuleSeparatedBy >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleSeparatedBy >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
PPTRuleSeparatedBy >> separator [
	^ separator
]

{ #category : #accessing }
PPTRuleSeparatedBy >> separator: anObject [
	separator := anObject
]
