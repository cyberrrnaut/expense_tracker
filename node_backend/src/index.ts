import express from "express";
import cors from 'cors';

import { PrismaClient } from "@prisma/client";

const app = express();
app.use(cors());

const prisma = new PrismaClient();

app.use(express.json());

app.get("/expenses",async (req,res)=>{

    const expenses =  await prisma.expense.findMany();
    res.json(expenses);
})

app.post("/expenses", async(req,res)=>{

    const {description,amount,date} = req.body;
    const expense = await prisma.expense.create({
        data:{
            description,
            amount,
            date: new Date(date),
        }
    })

    res.json(expense);
})


app.put("/expenses/:id", async(req,res)=>{
    const {id} = req.params;
    const {description,amount,date} = req.body;

    const updatedExpense  = await prisma.expense.update({
        where:{id:Number(id)},
        data:{
            description,
            amount,
            date:  new Date(date)
        }
    })


    res.json(updatedExpense);
})

app.delete("/expenses/:id",async(req,res)=>{
    const {id} = req.params;
   
    await prisma.expense.delete({
        where:{id:Number(id)}
    })

    res.sendStatus(204);

})


const port = 4000;
app.listen(port,()=>{
    console.log(`Server running on http://localhost:${port}`);

})