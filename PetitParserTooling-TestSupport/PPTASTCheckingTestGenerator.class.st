Class {
	#name : #PPTASTCheckingTestGenerator,
	#superclass : #Object,
	#category : #'PetitParserTooling-TestSupport'
}

{ #category : #'as yet unclassified' }
PPTASTCheckingTestGenerator >> storeMethod [
	((PCGMethodNode selector: #testOption1) bodyBlock: [ :body | body << (#self asPCGNode receiveMessage: #assert:equals: with: (PCGRealASTToPCGConverter visit: self) with: (((PWBDataWindowParserTest new setUp) perform: self selector with:  self arguments first value with: self arguments second value )) storeString asPCG)]) sourceCode
]
