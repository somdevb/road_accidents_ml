from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import TemplateView
from django.shortcuts import render, redirect

# Create your views here.

def index(request):
    return render(request, 'utilities/index.html')

def hello(request):
    return render(request, 'utilities/hello.html')

def form(request):
    return render(request, 'utilities/form.html')


def map(request):
    import time
    import numpy as np
    import queue

    TIMEOUT = 3
    firstFrame = None
    lastDec = None
    firstThresh = None

    feature_params = dict(maxCorners=50,
                        qualityLevel=0.3,
                        minDistance=7,
                        blockSize=7)
    color = np.random.randint(0, 255, (100, 3))
    num = 0

    q_x = queue.Queue(maxsize=2)
    #q_y = queue.Queue(maxsize=5)
    previous = ""
    trigger = 0
    counter = 0
    last_enter_time = -1
    while True:        
        if counter < 5:
            counter = counter+1
        else:
            counter = 0
            trigger = 0
        # print(counter)
        if firstFrame is None:
            firstFrame = 'gray'
            continue
            if q_x.full():
                qx_list = list(q_x.queue)
                key = 0
                diffx_sum = 0
                for item_x in qx_list:
                    key += 1
                    if key < 2:
                        diff_x = item_x - qx_list[key]
                        diffx_sum += diff_x
                # print(trigger)
                if diffx_sum < -20:
                    if trigger >= 0:
                        if 380 <= key <= 432:
                            print("EXIT")
                            last_enter_time = -1
                        trigger = 0
                    previous = "left"
                    if previous == "left":
                        trigger = trigger+1
                elif diffx_sum > 20:
                    previous = "right"
                    if previous == "right":
                        trigger = trigger-1
                
        return render(request, 'utilities/map11.html')

def coor(request):
    return render(request, 'utilities/form2.html')

def report(request):
    return render(request, 'utilities/report.html')

def thanks(request):
    # from django.core.mail import send_mail

    # send_mail(
    #     'Subject here',
    #     'Here is the message.',
    #     'shilpimukherjee72@gmail.com',
    #     ['somdevbasu100@gmail.com'],
    #     fail_silently=False,
    # )
    return HttpResponse('''<title>Thanks!</title>  <link href="https://fonts.googleapis.com/css?family=Poppins&display=swap" rel="stylesheet">
<body style = "background: black; font-family: Poppins, arial; color: white; padding: 10rem;"><h1>Thank you for the info!</h1><p>We work on crowdsourcing</p></body>''')

def processed(request):
    if(request.method == 'POST'):
        email = request.POST['email']
        processed = email + ' is a verified entry'
    return HttpResponse(processed)
