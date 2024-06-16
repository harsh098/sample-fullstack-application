import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateTodoDto } from './dto/create-todo.dto';
import { UpdateTodoDto } from './dto/update-todo.dto';
import { PrismaService } from 'src/global/prisma/prisma.service';

@Injectable()
export class TodoService {
  constructor(private prisma: PrismaService) { }

  create(createTodoDto: CreateTodoDto) {
    return this.prisma.todo.create({
      data: createTodoDto
    });
  }

  findAll() {
    return this.prisma.todo.findMany();
  }

  async findOne(id: number) {
    const todo = await this.prisma.todo.findUnique({
      where: { id }
    })

    if (!todo) {
      throw new HttpException('Todo not found', HttpStatus.NOT_FOUND);
    }
  }

  async update(id: number, updateTodoDto: UpdateTodoDto) {
    await this.findOne(id);

    return this.prisma.todo.update({
      where: { id },
      data: updateTodoDto
    })
  }

  async remove(id: number) {
    await this.findOne(id);

    return this.prisma.todo.delete({ 
      where: { id } 
    })
  }
}
