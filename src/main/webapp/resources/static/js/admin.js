//SIDEBAR TOGGLE

var sidebarOpen=false;
var sidebar=document.getElementById("sidebar");

function openSidebar(){
    if(!sidebarOpen){
        sidebar.classList.add("sidebar-responsive");
        sidebarOpen=true;
    }
}

function closeSidebar(){
    if(sidebarOpen){
        sidebar.classList.remove("sidebar-responsive");
            sidebarOpen=false;
        
    }
}

function renderBarChart(topProducts) {
    // Extract names and popularity
    const productNames = topProducts.map(product => product.productName);
    const productPopularity = topProducts.map(product => product.popularity);

    console.log("Rendering bar chart with data:", topProducts); // Debugging line

    // Bar chart options
    var barChartOptions = {
        series: [{
            data: productPopularity,
            name: "Products",
        }],
        chart: {
            type: "bar",
            background: "transparent",
            height: 350,
            toolbar: {
                show: false,
            },
        },
        colors: [
            "#2962ff",
            "#d50000",
            "#2e7d32",
            "#ff6d00",
            "#583cb3",
        ],
        plotOptions: {
            bar: {
                distributed: true,
                borderRadius: 4,
                horizontal: false,
                columnWidth: "40%",
            }
        },
        dataLabels: {
            enabled: false,
        },
        fill: {
            opacity: 1,
        },
        grid: {
            borderColor: "#55596e",
            yaxis: {
                lines: {
                    show: true,
                },
            },
            xaxis: {
                lines: {
                    show: true,
                },
            },
        },
        legend: {
            labels: {
                colors: "#f5f7ff",
            },
            show: true,
            position: "top",
        },
        stroke: {
            colors: ["transparent"],
            show: true,
            width: 2
        },
        tooltip: {
            shared: true,
            intersect: false,
            theme: "dark",
        },
        xaxis: {
            categories: productNames,
            title: {
                style: {
                    color: "#f5f7ff",
                },
            },
            axisBorder: {
                show: true,
                color: "#55596e",
            },
            axisTicks: {
                show: true,
                color: "#55596e",
            },
            labels: {
                style: {
                    colors: "#f5f7ff",
                },
            },
        },
        yaxis: {
            title: {
                text: "Count",
                style: {
                    color: "#f5f7ff",
                },
            },
            axisBorder: {
                color: "#55596e",
                show: true,
            },
            axisTicks: {
                color: "#55596e",
                show: true,
            },
            labels: {
                style: {
                    colors: "#f5f7ff",
                },
            },
        },
    };
    // Render the chart
    var barChart = new ApexCharts(document.querySelector("#bar-chart"), barChartOptions);
    barChart.render();
}
//AREA CHART
// Fetch sales data for area chart
fetch('/Project/sales-data-weekdays')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        var areaChartOptions = {
            series: [{
                name: "Sales Orders",
                data: data.data, // Sales amounts
            }],
            chart: {
                type: "area",
                background: "transparent",
                height: 350,
                stacked: false,
                toolbar: {
                    show: false,
                },
            },
            colors: ["#d50000"],
            labels: data.labels, // Weekday labels
            dataLabels: {
                enabled: false,
            },
            fill: {
                gradient: {
                    opacityFrom: 0.4,
                    opacityTo: 0.1,
                    shadeIntensity: 1,
                    stops: [0, 100],
                    type: "vertical",
                },
                type: "gradient",
            },
            grid: {
                borderColor: "#55596e",
                yaxis: {
                    lines: {
                        show: true,
                    },
                },
                xaxis: {
                    lines: {
                        show: true,
                    },
                },
            },
            legend: {
                labels: {
                    colors: "#f5f7ff",
                },
                show: true,
                position: "top",
            },
            markers: {
                size: 6,
                strokeColors: "#1b2635",
                strokeWidth: 3,
            },
            stroke: {
                curve: "smooth",
            },
            xaxis: {
                axisBorder: {
                    color: "#55596e",
                    show: true,
                },
                axisTicks: {
                    color: "#55596e",
                    show: true,
                },
                labels: {
                    offsetY: 5,
                    style: {
                        colors: "#f5f7ff",
                    },
                },
            },
            yaxis: {
                title: {
                    text: "Sales Amount",
                    style: {
                        color: "#f5f7ff",
                    },
                },
                labels: {
                    style: {
                        colors: ["#f5f7ff"],
                    },
                },
            },
            tooltip: {
                shared: true,
                intersect: false,
                theme: "dark",
            }
        };

        var areaChart = new ApexCharts(document.querySelector("#area-chart"), areaChartOptions);
        areaChart.render();
    })
    .catch(error => {
        console.error("Error fetching sales data:", error);
    });


/**
 * 
 */