using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using System.Threading;

namespace Probleem_220
{
    public partial class Form1 : Form
    {
        private List<Point> bigSteps;

        private double Cos = Math.Cos(45.0 / 180.0 * Math.PI);
        private double Sin = Math.Sin(45.0 / 180.0 * Math.PI);

        public Form1()
        {
            InitializeComponent();
        }

        private void        Form1_Load(object sender, EventArgs e)
        {
            UInt64 target = 1000000000000; //10^12
            // 2^38
            // 1110100011010100101001010001000000000000

            //UInt64 target = 512;

            int n = (int)Math.Ceiling(Math.Log(target) / Math.Log(2));
            bigSteps = CalculateBigSteps(n);

            DoShit(target);

            /*
            for (int i = 1; i <= (int)target; i++)
            {
                DoShit((ulong)i);
                Thread.Sleep(50);
            }
            */
            
            /*
            string D0 = "Fa";
            string D = CreateD(D0, 25);

            List<Point> points;
            int[] sizes = CalculateSizes(D, out points);

            Bitmap dragon = DrawGrid(sizes, points, bigSteps, new List<Point>(), 1);
            pictureBox1.Image = dragon;
            pictureBox1.Update();
            /**/
        }

        private void DoShit(ulong target)
        {
            List<Point> route = CalculateRoute(target);

            Console.WriteLine("Answer: "+route[route.Count-1].X.ToString()+","+route[route.Count-1].Y.ToString());

            /*
            string D0 = "Fa";
            string D = CreateD(D0, bigSteps.Count-1);

            List<Point> points;
            int[] sizes = CalculateSizes(D, out points);

            Bitmap dragon = DrawGrid(sizes, points, bigSteps, route, 10);
            pictureBox1.Image = dragon;
            pictureBox1.Update();
            /**/
        }

        private List<Point> CalculateBigSteps(int n)
        {
            List<Point> output = new List<Point>();
            output.Add(new Point(0, 1));
            for (int i = 1; i < n+1; i++)
            {
                //vector from the origin to the last point
                Point vector = new Point(output[i - 1].Y, -1 * output[i - 1].X);

                //add a 90 degree rotate version of vector to the last point!
                output.Add(new Point(output[i - 1].X + vector.X, output[i - 1].Y + vector.Y));
            }

            return output;
        }
        private List<Point> CalculateRoute(ulong target)
        {
            //route
            List<Point> route = new List<Point>();
            route.Add(new Point(0, 0));
            
            PerformStep(target, 0, ref route);

            return route;
        }
        private void        PerformStep(ulong target, int direction, ref List<Point> route)
        {
            Point current = route.Last();
            double power = Math.Log(target, 2);

            Point step1 = bigSteps[(int)Math.Floor(power)];
            ulong step1Number = (ulong)Math.Pow(2, (int)Math.Floor(power));
            Point step2 = bigSteps[(int)Math.Ceiling(power)];
            ulong step2Number = (ulong)Math.Pow(2, (int)Math.Ceiling(power));
            
            if (step2Number - target < target - step1Number)
            {
                //step2
                double Cos = Math.Cos(-45.0 * direction / 180.0 * Math.PI);
                double Sin = Math.Sin(-45.0 * direction / 180.0 * Math.PI);
                Point rotatedStep1 = new Point((int)Math.Round(step1.X * Cos - step1.Y * Sin), (int)Math.Round(step1.X * Sin + step1.Y * Cos));
                Point rotatedStep2 = new Point((int)Math.Round(step2.X * Cos - step2.Y * Sin), (int)Math.Round(step2.X * Sin + step2.Y * Cos));

                Point next = new Point(current.X + rotatedStep2.X, current.Y + rotatedStep2.Y);
                route.Add(next);

                if (step2Number - target != 0)
                {
                    Point temp = new Point((int)(current.X + rotatedStep1.X), (int)(current.Y + rotatedStep1.Y));
                    int nextDirection = DetermineDirection(direction, next, temp, (ulong)(step1Number));

                    PerformStep(step2Number - target, nextDirection, ref route);
                }
            }
            else
            {
                //step1
                double Cos = Math.Cos(-45.0 * direction / 180.0 * Math.PI);
                double Sin = Math.Sin(-45.0 * direction / 180.0 * Math.PI);
                Point rotatedStep1 = new Point((int)Math.Round(step1.X * Cos - step1.Y * Sin), (int)Math.Round(step1.X * Sin + step1.Y * Cos));
                Point rotatedStep2 = new Point((int)Math.Round(step2.X * Cos - step2.Y * Sin), (int)Math.Round(step2.X * Sin + step2.Y * Cos));
                
                Point next = new Point(current.X + rotatedStep1.X, current.Y + rotatedStep1.Y);
                route.Add(next);
                
                if (target - step1Number != 0)
                {
                    Point temp = new Point((int)(current.X + 0.5 * rotatedStep2.X), (int)(current.Y + 0.5 * rotatedStep2.Y));
                    int nextDirection = DetermineDirection(direction, next, temp, (ulong)(step1Number * 0.5));

                    PerformStep(target - step1Number, nextDirection, ref route);
                }
            }
        }
        private int         DetermineDirection(int direction, Point begin, Point end, ulong stepNumber)
        {
            Point difference = new Point(end.X - begin.X, end.Y - begin.Y);
            double angleRadian = Math.PI * 0.5 - Math.Atan2(difference.Y, difference.X);
            while (angleRadian < 0)
                angleRadian += 2.0 * Math.PI;

            while (angleRadian > 2.0 * Math.PI)
                angleRadian -= 2.0 * Math.PI;

            int temp = (int)((angleRadian / (Math.PI / 4.0)) + 0.5);

            int directionStep = ((int)Math.Log(stepNumber, 2) % 8);

            int output = temp - directionStep;

            return output;
        }

        private Bitmap      DrawGrid(int[] sizes, List<Point> points, List<Point> endpoints, List<Point> route, int gridSize)
        {
            int padding = 50; 
            Bitmap output = new Bitmap(gridSize*(Math.Abs(sizes[1])+Math.Abs(sizes[3])) + 2*padding, gridSize*(Math.Abs(sizes[2])+Math.Abs(sizes[0])) + 2* padding);

            int offsetX = Math.Abs(sizes[3]) * gridSize + padding;
            int offsetY = Math.Abs(sizes[0]) * gridSize + padding;

            using (Graphics g = Graphics.FromImage(output))
            {
                g.FillRectangle(Brushes.White, new Rectangle(0, 0, output.Width, output.Height));
                g.DrawLine(new Pen(Color.Black, 1), offsetX, offsetY, offsetX, padding/2);
                g.DrawLine(new Pen(Color.Black, 1), offsetX, offsetY, output.Width-padding/2, offsetY);
                for (int i = 1; i < points.Count; i++)
                {
                    g.DrawLine(new Pen(Color.Red, 1), points[i - 1].X * gridSize + offsetX, -points[i - 1].Y * gridSize + offsetY, points[i].X * gridSize + offsetX, -points[i].Y * gridSize + offsetY);
                }

                for(int i = 0; i < endpoints.Count(); i++)
                    g.FillEllipse(Brushes.Cyan, new Rectangle(endpoints[i].X * gridSize + offsetX - gridSize / 2, -endpoints[i].Y * gridSize + offsetY - gridSize / 2, gridSize, gridSize));

                for (int i = 0; i < route.Count(); i++)
                    g.FillEllipse(Brushes.Magenta, new Rectangle(route[i].X * gridSize + offsetX - gridSize / 2, -route[i].Y * gridSize + offsetY - gridSize / 2, gridSize, gridSize));

                if(route.Count != 0)
                    g.FillEllipse(Brushes.Yellow, new Rectangle(route.Last().X * gridSize + offsetX - gridSize / 2, -route.Last().Y * gridSize + offsetY - gridSize / 2, gridSize, gridSize));
            
            }

            return output;
        }
        
        private string      CreateD(string D0, int n)
        {
           
            string temp = D0;
            int i = 1;
            while (i <= n)
            {
                temp = temp.Replace("a", "aRzFR").Replace("b", "LFaLb");
                temp = temp.Replace("z", "b");
                i++;
            }

            return temp;
        }
        private int[]       CalculateSizes(string formula, out List<Point> points)
        {
            int[] sizes = new int[4]; //north east south west

            int step = 0;
            points = new List<Point>();
            points.Add(new Point(0, 0));
            Point position = new Point(0, 0);
            int direction = 0; //0 = north, 1 = east, 2 = south, 3 = west
            bool stop = false;
            for (int i = 0; (i < formula.Length) && !stop; i++)
            {
                switch (formula[i])
                {
                    case 'L':
                        direction--;
                        if (direction < 0)
                            direction = 3;
                        break;
                    case 'R':
                        direction++;
                        if (direction > 3)
                            direction = 0;
                        break;
                    case 'F':
                        step++;
                        switch (direction)
                        {
                            case 0:
                                position.Y++;
                                break;
                            case 1:
                                position.X++;
                                break;
                            case 2:
                                position.Y--;
                                break;
                            case 3:
                                position.X--;
                                break;
                        }
                        sizes[0] = Math.Max(sizes[0], position.Y); //north
                        sizes[1] = Math.Max(sizes[1], position.X); //east
                        sizes[2] = Math.Min(sizes[2], position.Y); //south
                        sizes[3] = Math.Min(sizes[3], position.X); //west
                        points.Add(new Point(position.X, position.Y));
                        //if (step == 500) //Math.Pow(10, 12))
                        //    stop = true;
                        break;
                    default:
                        //do nothing
                        break;
                }
            }

            return sizes;
        }
    }
}
