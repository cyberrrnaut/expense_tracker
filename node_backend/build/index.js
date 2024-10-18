"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const client_1 = require("@prisma/client");
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
const prisma = new client_1.PrismaClient();
app.use(express_1.default.json());
app.get("/expenses", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const expenses = yield prisma.expense.findMany();
    res.json(expenses);
}));
app.post("/expenses", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { description, amount, date } = req.body;
    const expense = yield prisma.expense.create({
        data: {
            description,
            amount,
            date: new Date(date),
        }
    });
    res.json(expense);
}));
app.put("/expenses/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { description, amount, date } = req.body;
    const updatedExpense = yield prisma.expense.update({
        where: { id: Number(id) },
        data: {
            description,
            amount,
            date: new Date(date)
        }
    });
    res.json(updatedExpense);
}));
app.delete("/expenses/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    yield prisma.expense.delete({
        where: { id: Number(id) }
    });
    res.sendStatus(204);
}));
const port = 4000;
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
