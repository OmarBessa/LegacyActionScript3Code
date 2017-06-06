package common.datastructures.doublylinkedlist.test
{
	import common.datastructures.doublylinkedlist.DoublyLinkedList;
	import common.datastructures.doublylinkedlist.DoublyLinkedListIterator;
	import common.datastructures.doublylinkedlist.DoublyLinkedListNode;
	import common.datastructures.interfaces.IIteratorImperative;
	import common.debug.ArraySampleGenerator;
	import common.oldfunctors.XEqualsY;
	
	import org.flexunit.Assert;

	public class TestDoublyLinkedList
	{			
		private var _generate : ArraySampleGenerator = new ArraySampleGenerator;
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testAppend():void
		{			
			var testList : DoublyLinkedList = new DoublyLinkedList;		
			testList.append( 0, 1, 2, 3 );
			
			Assert.assertTrue(
				new XEqualsY().run(
					testList.toArray(),
					_generate.integerSuccession( 3 )
				)
			);
		}
		
		[Test]
		public function testClear():void
		{			
			var a : DoublyLinkedList = new DoublyLinkedList( 1, 2, 3 );
			
			a.clear();
			
			Assert.assertEquals(
				a.isEmpty(),
				true
			);			
		}
		
		[Test]
		public function testConcat():void
		{			
			var listA : DoublyLinkedList = new DoublyLinkedList( 1, 2, 3 );
			var listB : DoublyLinkedList = new DoublyLinkedList( 4, 5, 6 );			
			var listC : DoublyLinkedList = listA.concat( listB ); 
			
			Assert.assertTrue(
				new XEqualsY().run(
					listC.toArray(),
					_generate.integerSuccession( 6, 1 )
				)
			);			
		}
		
		[Test]
		public function testCopy():void
		{			
			var a : DoublyLinkedList = new DoublyLinkedList( 1, 2, 3 );
			var c : DoublyLinkedList = a.copy();
			
			Assert.assertTrue(
				new XEqualsY().run(
					c.toArray(),
					a.toArray()
				)
			);			
		}
		
		[Test]
		public function testInsertValueAfter():void
		{			
			var a : DoublyLinkedList	= new DoublyLinkedList( 0, 1, 2, 3, 5 );
			var	i : IIteratorImperative	= new DoublyLinkedListIterator( a );
			
			i.advance();
			i.advance();
			i.advance();
			
			a.insertValueAfter( i.data, 4 )
			
			Assert.assertTrue(
				new XEqualsY().run(
					a.toArray(),
					_generate.integerSuccession( 5 )
				)
			);			
		}
		
		[Test]
		public function testInsertValueBefore():void
		{			
			var a : DoublyLinkedList	= new DoublyLinkedList( 0, 1, 2, 3, 5 );
			var	i : IIteratorImperative	= new DoublyLinkedListIterator( a );
			
			i.advance();
			i.advance();
			i.advance();
			i.advance();
			
			a.insertValueBefore( i.data, 4 )
			
			Assert.assertTrue(
				new XEqualsY().run(
					a.toArray(),
					_generate.integerSuccession( 5 )
				)
			);			
		}
		
		[Test]
		public function testIsEmpty():void
		{			
			var a : DoublyLinkedList = new DoublyLinkedList;
			
			Assert.assertEquals(
				a.isEmpty(),
				true
			);
		}
		
		[Test]
		public function testGet_length():void
		{			
			var prepending : DoublyLinkedList = new DoublyLinkedList( 4, 5, 6 );		
			prepending.prepend( 0, 1, 2, 3 );
			
			Assert.assertEquals(
				prepending.length,
				7
			);
		}
		
		[Test]
		public function testMerge():void
		{			
			var listA : DoublyLinkedList = new DoublyLinkedList( 1, 2, 3 );
			var listB : DoublyLinkedList = new DoublyLinkedList( 4, 5, 6 );			
			var listC : DoublyLinkedList = new DoublyLinkedList( 7, 8, 9 );
			
			listA.merge( listB, listC );
			
			Assert.assertTrue(
				new XEqualsY().run(
					listA.toArray(),
					_generate.integerSuccession( 9, 1 )
				)
			);
		}
		
		[Test]
		public function testPrepend():void
		{			
			var prepending : DoublyLinkedList = new DoublyLinkedList( 4, 5, 6 );		
			prepending.prepend( 0, 1, 2, 3 );
			
			Assert.assertTrue(
				new XEqualsY().run(
					prepending.toArray(),
					_generate.integerSuccession( 6 )
				)
			);
		}
		
		[Test]
		public function testRemoveFromMid():void
		{			
			var a : DoublyLinkedList	= new DoublyLinkedList(0, 1, 2, 5, 3);
			var	i : IIteratorImperative	= new DoublyLinkedListIterator(a);
			
			i.advance();
			i.advance();
			i.advance();
			
			a.remove(i.data);
			
			Assert.assertTrue(
				new XEqualsY().run(
					a.toArray(),
					_generate.integerSuccession(3)
				)
			);			
		}
		
		[Test]
		public function testRemoveOneByOne():void
		{			
			var a : DoublyLinkedList	=  new DoublyLinkedList(0, 1, 2, 5, 3);
			var p : DoublyLinkedListNode = a.head;
			var h : DoublyLinkedListNode;
			
			while (p) {
				h = p.next;
				a.remove(p);
				p = h;
			}
			
			Assert.assertTrue(a.length == 0);			
		}
		
		[Test]
		public function testSwap():void
		{			
			var swapping : DoublyLinkedList = new DoublyLinkedList;
			
			var zero	: DoublyLinkedListNode = swapping.append( 0 );
			var one		: DoublyLinkedListNode = swapping.append( 1 );
			var three	: DoublyLinkedListNode = swapping.append( 3 );
			var two		: DoublyLinkedListNode = swapping.append( 2 );
			var four	: DoublyLinkedListNode = swapping.append( 4 );
			
			swapping.swap( three, two );
			
			Assert.assertTrue(
				new XEqualsY().run(
					swapping.toArray(),
					_generate.integerSuccession( 4 )
				)
			);
		}
		
		[Test]
		public function testToArray():void
		{			
			Assert.assertTrue(
				new XEqualsY().run(
					new DoublyLinkedList(0, 1).toArray(),
					new Array(0, 1)
				)
			);
		}
		
		[Test]
		public function testConstructionWithValues():void
		{			
			Assert.assertTrue(
				new XEqualsY().run(
					new DoublyLinkedList(0, 1, 2, 3, 4, 5).toArray(),
					_generate.integerSuccession(5)
				)
			);
		}
		
		[Test]
		public function testWalk():void
		{			
			var a : DoublyLinkedList = new DoublyLinkedList( 0, 1, 2, 3, 4, 5 );
			
			var count : Array = new Array;
			
			var counter : Function = function (x : *) : void { count.push(x.data) };
			
			a.walk(counter);
			
			Assert.assertTrue(
				new XEqualsY().run(
					count,
					this._generate.integerSuccession(5)
				)
			);			
		}
	}
}