<?php
/**
 * Copyright © Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */
namespace Magento\Framework\DB\Test\Unit;

use Magento\Framework\TestFramework\Unit\Helper\ObjectManager;
use Magento\Framework\DB\FieldDataConverterFactory;
use Magento\Framework\ObjectManagerInterface;
use Magento\Framework\DB\FieldDataConverter;
use Magento\Framework\DB\DataConverter\DataConverterInterface;

class FieldDataConverterFactoryTest extends \PHPUnit\Framework\TestCase
{
    /**
     * @var ObjectManagerInterface|\PHPUnit\Framework\MockObject\MockObject
     */
    private $objectManagerMock;

    /**
     * @var DataConverterInterface|\PHPUnit\Framework\MockObject\MockObject
     */
    private $dataConverterMock;

    /**
     * @var FieldDataConverterFactory
     */
    private $fieldDataConverterFactory;

    protected function setUp(): void
    {
        $objectManager = new ObjectManager($this);
        $this->objectManagerMock = $this->getMockForAbstractClass(ObjectManagerInterface::class);
        $this->dataConverterMock = $this->getMockForAbstractClass(DataConverterInterface::class);
        $this->fieldDataConverterFactory = $objectManager->getObject(
            FieldDataConverterFactory::class,
            [
                'objectManager' => $this->objectManagerMock
            ]
        );
    }

    public function testCreate()
    {
        $dataConverterClassName = 'ClassName';
        $fieldDataConverterInstance = 'field data converter instance';
        $this->objectManagerMock->expects($this->once())
            ->method('get')
            ->with($dataConverterClassName)
            ->willReturn($this->dataConverterMock);
        $this->objectManagerMock->expects($this->once())
            ->method('create')
            ->with(
                FieldDataConverter::class,
                [
                    'dataConverter' => $this->dataConverterMock
                ]
            )
            ->willReturn($fieldDataConverterInstance);
        $this->assertEquals(
            $fieldDataConverterInstance,
            $this->fieldDataConverterFactory->create($dataConverterClassName)
        );
    }
}
